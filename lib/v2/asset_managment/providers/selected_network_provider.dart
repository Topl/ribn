import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ribn/v2/asset_managment/models/chains.dart';

final selectedChainProvider = StateProvider<Chains>((ref) {
  return kDebugMode ? const Chains.private_network() : const Chains.topl_mainnet();
});

final chainsProvider = StateNotifierProvider<ChainsNotifier, List<Chains>>((ref) {
  return ChainsNotifier(ref);
});

class ChainsNotifier extends StateNotifier<List<Chains>> {
  final Ref ref;
  ChainsNotifier(this.ref)
      : super([
          const Chains.topl_mainnet(),
          const Chains.valhalla_testnet(),
          const Chains.private_network(),
          const Chains.dev_network(),
          const Chains.mock(),
        ]) {}
}
