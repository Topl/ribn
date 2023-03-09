// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_error_model.freezed.dart';

@freezed
class DebugErrorModel with _$DebugErrorModel {
  // Added constructor. Must not have any parameter
  const DebugErrorModel._();

  const factory DebugErrorModel({
    required String errorMessage,
  }) = _DebugErrorModel;
}
