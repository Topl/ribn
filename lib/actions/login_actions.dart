class AttemptLoginAction {
  final String password;
  const AttemptLoginAction(this.password);
}

class LoginSuccessAction {
  const LoginSuccessAction();
}

class LoginFailureAction {}

class LoginLoadingAction {}

class FirstTimeLoginAction {}
