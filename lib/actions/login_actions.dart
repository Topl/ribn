import 'dart:typed_data';

class AttemptLoginAction {
  final String password;
  const AttemptLoginAction(this.password);
}

class LoginSuccessAction {
  final Uint8List toplExtendedPrivateKey;
  LoginSuccessAction(this.toplExtendedPrivateKey);
}

class LoginFailureAction {}

class LoginLoadingAction {}
