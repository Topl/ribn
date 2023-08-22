// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypt_user_data.freezed.dart';

@freezed
class EncryptUserData with _$EncryptUserData {
  const factory EncryptUserData({
    required String mnemonic,
    required String pin,
  }) = _EncryptUserData;
}
