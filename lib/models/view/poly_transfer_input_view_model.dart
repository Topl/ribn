import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ribn/models/ribn_network.dart';

part 'poly_transfer_input_view_model.freezed.dart';

@freezed
class PolyTransferInputViewModel with _$PolyTransferInputViewModel {
  // Added constructor. Must not have any parameter
  // const PolyTransferInputViewModel._();

  const factory PolyTransferInputViewModel({
    /// Handler for initiating poly transfer tx.
    required Future<void> Function({
      required String amount,
      bool mintingToMyWallet,
      required String note,
      required void Function(bool) onRawTxCreated,
      required String recipient,
    })
        initiateTx,

    /// Tx fee for the current network.
    required num networkFee,

    /// Current network id.
    required RibnNetwork currentNetwork,

    /// Maximum amount available for transfer.
    required num maxTransferrableAmount,

    /// Allows redirect to asset transfer input through redux action
    required Function navigateToSendAssets,
  }) = _PolyTransferInputViewModel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PolyTransferInputViewModel &&
        other.networkFee == networkFee &&
        other.currentNetwork == currentNetwork;
  }
}
