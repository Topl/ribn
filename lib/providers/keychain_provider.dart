import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/providers/store_provider.dart';

final keychainProvider = StateNotifierProvider<KeychainNotifier, KeychainState>((ref) {
  return KeychainNotifier(ref);
});

class KeychainNotifier extends StateNotifier<KeychainState> {
  final Ref ref;
  KeychainNotifier(this.ref)
      : super(KeychainState(
          networks: Map.unmodifiable(RibnNetwork.initializeToplNetworks()),
          currentNetworkName: NetworkUtils.valhalla,
        ));

  Future<void> initializeHdWallet({
    required Uint8List toplExtendedPrivateKey,
    String? keyStoreJson,
  }) async {
    final Store<AppState> store = ref.read(storeProvider);

    await store.dispatch(
      InitializeHDWalletAction(
        toplExtendedPrivateKey: toplExtendedPrivateKey,
        keyStoreJson: keyStoreJson,
      ),
    );
  }
}
