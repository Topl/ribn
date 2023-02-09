// Dart imports:
import 'dart:typed_data';

class SuccessfullyRestoredWalletAction {
  final String keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const SuccessfullyRestoredWalletAction({
    required this.keyStoreJson,
    required this.toplExtendedPrivateKey,
  });
}
