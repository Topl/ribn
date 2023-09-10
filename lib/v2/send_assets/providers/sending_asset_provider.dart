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
      from: "",
      to: "",
      amount: "",
      fee: "",
    );
  }

  void updateFrom(String from) {
    state = state.copyWith(from: from);
  }

  void updateTo(String to) {
    state = state.copyWith(to: to);
  }

  void updateAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void updateFee(String fee) {
    state = state.copyWith(fee: fee);
  }

  //
  Future<void> sendTransaction() async {
    await ref.read(sendingAssetProvider.notifier)
  }
}
