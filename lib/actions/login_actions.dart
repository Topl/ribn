class AttemptLoginAction {
  final String password;
  final String keyStoreJson;
  const AttemptLoginAction(this.password, this.keyStoreJson);
}

class LoginSuccessAction {
  const LoginSuccessAction();
}

class LoginFailureAction {}

class LoginLoadingAction {}

class FirstTimeLoginAction {}
