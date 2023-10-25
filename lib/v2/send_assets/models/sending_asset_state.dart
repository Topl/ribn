import 'package:freezed_annotation/freezed_annotation.dart';

part 'sending_asset_state.freezed.dart';

@freezed
class SendingAssetState with _$SendingAssetState {
  const factory SendingAssetState({
    required String assetName,
    required String from,
    required String to,
    required double amount,
    required String fee,
  }) = _SendingAssetState;

  factory SendingAssetState.initial() => SendingAssetState(
        assetName: "",
        from: "",
        to: "",
        amount: 0.0,
        fee: "",
      );
}
