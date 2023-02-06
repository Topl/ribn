import 'package:bip_topl/bip_topl.dart';
import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/keychain_state.dart';
import 'package:ribn/models/ribn_network.dart';

final keychainProvider = StateNotifierProvider<KeychainNotifier, KeychainState>((ref) {
  return KeychainNotifier();
});

class KeychainNotifier extends StateNotifier<KeychainState> {
  KeychainNotifier()
      : super(KeychainState(
          networks: Map.unmodifiable(RibnNetwork.initializeToplNetworks()),
          currentNetworkName: NetworkUtils.valhalla,
        ));

  initializeHdWallet({
    required Uint8List toplExtendedPrivateKey,
    String? keyStoreJson,
  }) {
    state = state.copyWith(
      keyStoreJson: keyStoreJson ?? state.keyStoreJson,
      hdWallet: HdWallet(
        rootSigningKey: Bip32SigningKey.fromValidBytes(
          toplExtendedPrivateKey,
          depth: Rules.toplKeyDepth,
        ),
      ),
    );
  }
}
