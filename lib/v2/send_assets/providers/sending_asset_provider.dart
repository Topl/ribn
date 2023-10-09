import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/models/sending_asset_state.dart';

final sendingAssetProvider = StateNotifierProvider<SendingAssetNotifier, SendingAssetState>((ref) {
  return SendingAssetNotifier(ref);
});

class SendingAssetNotifier extends StateNotifier<SendingAssetState> {
  final Ref ref;

  SendingAssetNotifier(this.ref) : super(_initializeSendingAssetState(ref)) {}

  static SendingAssetState _initializeSendingAssetState(ref) {
    return SendingAssetState(
      assetName: "",
      from: "",
      to: "",
      amount: 0.0,
      fee: "",
    );
  }

  void updateFrom(String from) {
    state = state.copyWith(from: from);
  }

  void setAssetName(String assetName) {
    state = state.copyWith(assetName: assetName);
  }

  void updateTo(String to) {
    state = state.copyWith(to: to);
  }

  void updateAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void updateFee(String fee) {
    state = state.copyWith(fee: fee);
  }

  void reset() {
    state = SendingAssetState.initial();
  }

  /// Gets the details from the state
  /// and sends the transaction
  Future<void> sendTransaction() async {
    // access state details below to send transaction
    // final sendingAssetState = await ref.read(sendingAssetProvider.notifier);
  }
}
