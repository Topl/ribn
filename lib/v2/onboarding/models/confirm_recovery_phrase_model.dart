// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_recovery_phrase_model.freezed.dart';

@freezed
class ConfirmRecoveryPhraseModel with _$ConfirmRecoveryPhraseModel {
  const factory ConfirmRecoveryPhraseModel({
    required String phraseString,
    required bool isCorrect,
  }) = _ConfirmRecoveryPhraseModel;
}
