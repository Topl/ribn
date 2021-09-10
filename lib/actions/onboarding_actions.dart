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

class VerifyMnemonicAction {
  final String userInput;
  const VerifyMnemonicAction(this.userInput);
}

class MnemonicSuccessfullyVerifiedAction {}

class MnemonicMismatchAction {}

class UserSelectedWordAction {
  final String word;
  const UserSelectedWordAction(this.word);
}

class UserRemovedWordAction {
  final String word;
  const UserRemovedWordAction(this.word);
}
