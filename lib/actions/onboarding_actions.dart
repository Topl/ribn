class CreatePasswordAction {
  final String password;
  final String confirmPassword;
  const CreatePasswordAction(this.password, this.confirmPassword);
}

class PasswordSuccessfullyCreatedAction {
  final String keyStoreJson;
  final String mnemonic;
  PasswordSuccessfullyCreatedAction(this.keyStoreJson, this.mnemonic);
}

class PasswordMismatchAction {}

class PasswordTooShortAction {}

class LoadingPasswordValidationAction {}

class ErrorCreatingPasswordAction {}
