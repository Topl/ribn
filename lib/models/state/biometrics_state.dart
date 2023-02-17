import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometrics_state.freezed.dart';

@freezed
class BiometricsState with _$BiometricsState {
  // Added constructor. Must not have any parameter
  const BiometricsState._();

  const factory BiometricsState({
    @Default(false) bool isSupported,
    @Default(false) bool isEnabled,
    @Default(false) bool authorized,
  }) = _BiometricsState;


}

