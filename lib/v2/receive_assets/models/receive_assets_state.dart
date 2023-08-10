import 'package:freezed_annotation/freezed_annotation.dart';

part 'receive_assets_state.freezed.dart';

@freezed
class ReceiveAssetsState with _$ReceiveAssetsState {
  const factory ReceiveAssetsState({
    @Default(0) int pageIndex,
  }) = _ReceiveAssetsState;
}
