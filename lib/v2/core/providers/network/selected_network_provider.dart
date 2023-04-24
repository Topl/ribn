// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/models/network.dart';

// Project imports:

final selectedNetworkNotifierProvider = StateNotifierProvider.autoDispose<SelectedNetworkNotifier, Network>((ref) {
  return SelectedNetworkNotifier();
});

class SelectedNetworkNotifier extends StateNotifier<Network> {
  SelectedNetworkNotifier() : super(Network.topl_mainnet);

  changeKeychain(Network keychain) {
    state = keychain;
  }
}
