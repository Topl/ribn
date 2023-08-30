// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/network.dart';

// Project imports:

final selectedNetworkNotifierProvider = StateNotifierProvider.autoDispose<SelectedNetworkNotifier, Network>((ref) {
  return SelectedNetworkNotifier();
});

class SelectedNetworkNotifier extends StateNotifier<Network> {
  SelectedNetworkNotifier() : super(Network.topl_mainnet);

  List<String> networks() => Network.values.map((e) => e.name).toList();

  changeKeychain(Network keychain) {
    state = keychain;
  }
}
