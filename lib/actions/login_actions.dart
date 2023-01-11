// Dart imports:
import 'dart:async';
import 'dart:typed_data';

class AttemptLoginAction {
  final String password;
  final Completer completer;
  const AttemptLoginAction(this.password, this.completer);
}

class LoginSuccessAction {
  final Uint8List toplExtendedPrvKeyUint8List;
  const LoginSuccessAction(this.toplExtendedPrvKeyUint8List);
}
