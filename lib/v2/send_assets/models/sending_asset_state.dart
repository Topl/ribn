import 'package:freezed_annotation/freezed_annotation.dart';

part 'sending_asset_state.freezed.dart';

@freezed
class SendingAssetState with _$SendingAssetState {
  const factory SendingAssetState({
    required String from,
    required String to,
    required String amount,
    required String fee,
  }) = _SendingAssetState;

  factory SendingAssetState.initial() => SendingAssetState(
        from: "",
        to: "",
        amount: "",
        fee: "",
      );
}
