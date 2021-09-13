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
  final List<String> shuffledMnemonic;
  final bool mnemonicMismatchError;
  final List<int> userSelectedIndices;
  final Function(String) verifyMnemonic;
  final Function(int) selectWord;
  final Function(int) removeWord;

  const SeedPhraseConfirmationViewModel({
    this.mnemonicMismatchError = false,
    required this.verifyMnemonic,
    required this.shuffledMnemonic,
    required this.userSelectedIndices,
    required this.selectWord,
    required this.removeWord,
  });

  static SeedPhraseConfirmationViewModel fromStore(Store<AppState> store) {
    return SeedPhraseConfirmationViewModel(
      shuffledMnemonic: store.state.onboardingState.shuffledMnemonic!,
      userSelectedIndices: store.state.onboardingState.userSelectedIndices!,
      mnemonicMismatchError: store.state.onboardingState.mnemonicMismatchError,
      verifyMnemonic: (words) => store.dispatch(VerifyMnemonicAction(words)),
      selectWord: (idx) => store.dispatch(UserSelectedWordAction(idx)),
      removeWord: (idx) => store.dispatch(UserRemovedWordAction(idx)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeedPhraseConfirmationViewModel &&
        listEquals(other.shuffledMnemonic, shuffledMnemonic) &&
        other.mnemonicMismatchError == mnemonicMismatchError &&
        listEquals(other.userSelectedIndices, userSelectedIndices) &&
        other.verifyMnemonic == verifyMnemonic &&
        other.selectWord == selectWord &&
        other.removeWord == removeWord;
  }

  @override
  int get hashCode {
    return shuffledMnemonic.hashCode ^
        mnemonicMismatchError.hashCode ^
        userSelectedIndices.hashCode ^
        verifyMnemonic.hashCode ^
        selectWord.hashCode ^
        removeWord.hashCode;
  }
}
