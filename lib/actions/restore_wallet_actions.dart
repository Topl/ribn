import 'dart:typed_data';

class RestoreWalletWithMnemonicAction {
  final String mnemonic;
  final String password;
  const RestoreWalletWithMnemonicAction({required this.mnemonic, required this.password});
}

class RestoreWalletWithToplKey {
  final String toplKeyStoreJson;
  final String password;
  const RestoreWalletWithToplKey({required this.toplKeyStoreJson, required this.password});
}

class SuccessfullyRestoredWalletAction {
  final String keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const SuccessfullyRestoredWalletAction({required this.keyStoreJson, required this.toplExtendedPrivateKey});
}

class FailedToRestoreWalletAction {}
