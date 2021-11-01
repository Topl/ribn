class CreatePasswordAction {
  final String password;
  const CreatePasswordAction(this.password);
}

class PasswordSuccessfullyCreatedAction {
  PasswordSuccessfullyCreatedAction();
}

class GenerateMnemonicAction {}

class MnemonicSuccessfullyGeneratedAction {
  final String mnemonic;
  const MnemonicSuccessfullyGeneratedAction(this.mnemonic);
}

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
