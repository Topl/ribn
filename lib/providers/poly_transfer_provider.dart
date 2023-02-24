import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/view/poly_transfer_input_view_model.dart';

final polyTransferInputProvider =
    StateNotifierProvider<PolyTransferInputNotifier, PolyTransferInputViewModel>((ref) {
  return PolyTransferInputNotifier();
});

class PolyTransferInputNotifier extends StateNotifier<PolyTransferInputViewModel> {
  PolyTransferInputNotifier() : super(PolyTransferInputViewModel());
}
