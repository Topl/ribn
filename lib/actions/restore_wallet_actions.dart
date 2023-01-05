// Dart imports:
import 'dart:async';
import 'dart:typed_data';

class RestoreWalletWithMnemonicAction {
  final String mnemonic;
  final String password;
  RestoreWalletWithMnemonicAction(
      {required this.mnemonic, required this.password,});
}

class RestoreWalletWithToplKeyAction {
  final String toplKeyStoreJson;
  final String password;
  final Completer<bool> completer;

  const RestoreWalletWithToplKeyAction({
    required this.toplKeyStoreJson,
    required this.password,
    required this.completer,
  });
}

class SuccessfullyRestoredWalletAction {
  final String keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const SuccessfullyRestoredWalletAction(
      {required this.keyStoreJson, required this.toplExtendedPrivateKey,});
}

class FailedToRestoreWalletAction {}
