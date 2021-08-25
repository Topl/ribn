class CreatePasswordAction {
  final String password;
  final String confirmPassword;
  const CreatePasswordAction(this.password, this.confirmPassword);
}

class PasswordMismatchAction {}

class PasswordTooShortAction {}

class LoadingPasswordValidationAction {}
