import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/view/asset_transfer_input_view_model.dart';

final assetTransferProvider =
    StateNotifierProvider<AssetTransferNotifier, AssetTransferInputViewModel>((ref) {
  return AssetTransferNotifier();
});

class AssetTransferNotifier extends StateNotifier<AssetTransferInputViewModel> {
  AssetTransferNotifier() : super(AssetTransferInputViewModel());
}
