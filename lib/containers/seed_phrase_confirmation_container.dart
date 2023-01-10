// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/app_state.dart';

class SeedPhraseConfirmationContainer extends StatelessWidget {
  const SeedPhraseConfirmationContainer({
    Key? key,
    required this.builder,
    this.onInit,
  }) : super(key: key);
  final ViewModelBuilder<SeedPhraseConfirmationViewModel> builder;
  final Function(Store<AppState>)? onInit;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SeedPhraseConfirmationViewModel>(
      distinct: true,
      converter: SeedPhraseConfirmationViewModel.fromStore,
      builder: builder,
      onInit: onInit,
    );
  }
}

@immutable
class SeedPhraseConfirmationViewModel {
  final List<String> shuffledMnemonic;
  final List<String> mnemonicWordsList;
  final List<int> userSelectedIndices;
  final List<int> confirmeIdxs;
  final bool finishedInputting;
  final Function(int) selectWord;

  const SeedPhraseConfirmationViewModel({
    required this.mnemonicWordsList,
    required this.shuffledMnemonic,
    required this.userSelectedIndices,
    required this.selectWord,
    required this.finishedInputting,
    required this.confirmeIdxs,
  });

  static SeedPhraseConfirmationViewModel fromStore(Store<AppState> store) {
    return SeedPhraseConfirmationViewModel(
      shuffledMnemonic: store.state.onboardingState.shuffledMnemonic!,
      mnemonicWordsList:
          store.state.onboardingState.mnemonic!.split(' ').toList(),
      userSelectedIndices: store.state.onboardingState.userSelectedIndices!,
      finishedInputting:
          store.state.onboardingState.userSelectedIndices?.length ==
              store.state.onboardingState.shuffledMnemonic?.length,
      selectWord: (idx) => store.dispatch(UserSelectedWordAction(idx)),
      confirmeIdxs: store.state.onboardingState.mobileConfirmIdxs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeedPhraseConfirmationViewModel &&
        listEquals(other.shuffledMnemonic, shuffledMnemonic) &&
        listEquals(other.mnemonicWordsList, mnemonicWordsList) &&
        listEquals(other.userSelectedIndices, userSelectedIndices) &&
        other.selectWord == selectWord;
  }

  @override
  int get hashCode {
    return shuffledMnemonic.hashCode ^
        mnemonicWordsList.hashCode ^
        userSelectedIndices.hashCode ^
        selectWord.hashCode;
  }
}
