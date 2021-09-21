class CreatePasswordAction {
  final String password;
  final String confirmPassword;
  const CreatePasswordAction(this.password, this.confirmPassword);
}

class PasswordSuccessfullyCreatedAction {
  final String mnemonic;
  PasswordSuccessfullyCreatedAction(this.mnemonic);
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
  final int idx;
  const UserSelectedWordAction(this.idx);
}

class UserRemovedWordAction {
  final int idx;
  const UserRemovedWordAction(this.idx);
}
