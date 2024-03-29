// Dart imports:

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart' as bip_topl;
import 'package:brambldart/brambldart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/keychain_actions.dart';
import 'package:ribn/v1/constants/network_utils.dart';
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/ribn_address.dart';
import 'package:ribn/v1/redux.dart';
import 'package:ribn/v1/repositories/keychain_repository.dart';
import 'test_data.dart';

void main() {
  group('AppState reducer', () {
    final String testKeyStore = testData['keyStoreJson']!;
    final Uint8List testToplExtendedPrivKey = Uint8List.fromList(toList(testData['toplExtendedPrvKey']!));
    late Store<AppState> testStore;
    setUp(() async {
      await Redux.initStore(initTestStore: false);
      testStore = Redux.store!;
    });

    group('Onboarding reducer', () {});
    group('Network reducer', () {
      test('keyStoreJson and hd wallet initialization', () async {
        final HdWallet hdWallet = HdWallet(
          rootSigningKey: bip_topl.Bip32SigningKey.fromValidBytes(
            testToplExtendedPrivKey,
            depth: Rules.toplKeyDepth,
          ),
        );
        testStore.dispatch(
          InitializeHDWalletAction(
            keyStoreJson: testKeyStore,
            toplExtendedPrivateKey: testToplExtendedPrivKey,
          ),
        );
        expect(testStore.state.keychainState.keyStoreJson, testKeyStore);
        expect(
          testStore.state.keychainState.hdWallet!.rootVerifyKey,
          hdWallet.rootVerifyKey,
        );
      });
      test('update network with addresses', () async {
        const KeychainRepository keychainRepo = KeychainRepository();
        final HdWallet hdWallet = HdWallet(
          rootSigningKey: bip_topl.Bip32SigningKey.fromValidBytes(
            testToplExtendedPrivKey,
            depth: Rules.toplKeyDepth,
          ),
        );
        final Map<String, List<RibnAddress>> networkAddresses = {};
        testStore.state.keychainState.networks.forEach((networkName, network) {
          networkAddresses[networkName] = [keychainRepo.generateAddress(hdWallet, networkId: network.networkId)];
        });
        testStore.dispatch(UpdateNetworksWithAddressesAction(networkAddresses));
        testStore.state.keychainState.networks.forEach((networkName, network) {
          listEquals(
            testStore.state.keychainState.networks[networkName]!.addresses,
            networkAddresses[networkName],
          );
        });
      });
      test('toggle network', () async {
        testStore.dispatch(UpdateCurrentNetworkAction(NetworkUtils.private));
        expect(
          testStore.state.keychainState.currentNetwork.networkName,
          NetworkUtils.private,
        );
      });
    });
  });
}
