import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/view/mint_input_view_model.dart';

final mintInputProvider = StateNotifierProvider<MintInputNotifier, MintInputViewModel>((ref) {
  return MintInputNotifier();
});

class MintInputNotifier extends StateNotifier<MintInputViewModel> {
  MintInputNotifier() : super(MintInputViewModel());
}
