import 'dart:typed_data';

class AttemptLoginAction {
  final String password;
  const AttemptLoginAction(this.password);
}

class LoginSuccessAction {
  final Uint8List toplExtendedPrvKeyUint8List;
  const LoginSuccessAction(this.toplExtendedPrvKeyUint8List);
}

class LoginFailureAction {}

class LoginLoadingAction {}

class FirstTimeLoginAction {}
