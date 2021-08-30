import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/app_state.dart';

class SeedPhraseConfirmationContainer extends StatelessWidget {
  const SeedPhraseConfirmationContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<SeedPhraseConfirmationViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SeedPhraseConfirmationViewModel>(
      distinct: true,
      converter: (store) => SeedPhraseConfirmationViewModel.fromStore(store),
      builder: builder,
    );
  }
}

@immutable
class SeedPhraseConfirmationViewModel {
  final String mnemonic;
  final List<String> shuffledMnemonic;
  final bool mnemonicMismatchError;
  final List<String> userSelectedWords;
  final Function(String) verifyMnemonic;
  final Function(String) selectWord;
  final Function(String) removeWord;

  const SeedPhraseConfirmationViewModel({
    required this.mnemonic,
    this.mnemonicMismatchError = false,
    required this.verifyMnemonic,
    required this.shuffledMnemonic,
    required this.userSelectedWords,
    required this.selectWord,
    required this.removeWord,
  });

  static SeedPhraseConfirmationViewModel fromStore(Store<AppState> store) {
    return SeedPhraseConfirmationViewModel(
      mnemonic: store.state.onboardingState.mnemonic ?? "",
      shuffledMnemonic: store.state.onboardingState.shuffledMnemonic ?? [],
      userSelectedWords: store.state.onboardingState.userSelectedWords ?? [],
      mnemonicMismatchError: store.state.onboardingState.mnemonicMismatchError,
      verifyMnemonic: (words) => store.dispatch(VerifyMnemonicAction(words)),
      selectWord: (word) => store.dispatch(UserSelectedWordAction(word)),
      removeWord: (word) => store.dispatch(UserRemovedWordAction(word)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeedPhraseConfirmationViewModel &&
        other.mnemonic == mnemonic &&
        listEquals(other.shuffledMnemonic, shuffledMnemonic) &&
        other.mnemonicMismatchError == mnemonicMismatchError &&
        other.verifyMnemonic == verifyMnemonic;
  }

  @override
  int get hashCode {
    return mnemonic.hashCode ^
        shuffledMnemonic.hashCode ^
        mnemonicMismatchError.hashCode ^
        verifyMnemonic.hashCode;
  }
}
