// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/keychain_actions.dart';
import 'package:ribn/v1/constants/network_utils.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/keychain_state.dart';
import 'package:ribn/v1/models/ribn_network.dart';
import 'package:ribn/v1/providers/store_provider.dart';

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
