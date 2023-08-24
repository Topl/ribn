import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_asset_state.freezed.dart';

@freezed
class SendAssetState with _$SendAssetState {
  const factory SendAssetState({
    @Default(0) int pageIndex,
  }) = _SendAssetState;
}
