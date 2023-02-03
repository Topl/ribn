// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/providers/onboarding_provider.dart';

// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';

class SeedPhraseConfirmationPage extends HookConsumerWidget {
  SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);

    useEffect(() {
      return () {
        _formKey.currentState?.dispose();
      };
    });

    final List<String> mnemonicWordsList = onboardingState.shuffledMnemonic;
    final List<int> confirmeIdxs = onboardingState.mobileConfirmIdxs;

    print('QQQQ mnemonicWordsList $mnemonicWordsList');
    print('QQQQ confirmeIdxs $confirmeIdxs');

    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                renderIfWeb(const WebOnboardingAppBar(currStep: 1)),
                SizedBox(
                  width: 200,
                  child: Text(
                    Strings.writeDownSeedPhrase,
                    style: RibnToolkitTextStyles.onboardingH1.copyWith(letterSpacing: 0.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(RibnAssets.penPaperPng, width: 70),
                Padding(
                  padding: EdgeInsets.only(
                    top: adaptHeight(0.04),
                    bottom: adaptHeight(0.02),
                  ),
                  child: const Text(
                    Strings.ensureYourWordsAreCorrect,
                    style: RibnToolkitTextStyles.onboardingH3,
                  ),
                ),
                _SeedPhraseConfirmationGrid(
                  confirmIdxs: confirmeIdxs,
                  mnemonicWordsList: mnemonicWordsList,
                ),
                const SizedBox(height: 40),
                renderIfMobile(
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: OnboardingProgressBar(numSteps: 4, currStep: 1),
                  ),
                ),
                ConfirmationButton(
                  text: Strings.done,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Keys.navigatorKey.currentState?.pushNamed(Routes.createPassword);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SeedPhraseConfirmationGrid extends StatelessWidget {
  final List<int> confirmIdxs;
  final List<String> mnemonicWordsList;
  const _SeedPhraseConfirmationGrid({
    required this.confirmIdxs,
    required this.mnemonicWordsList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> mobileRows = [];
    List<Widget> webRowChildren = [];
    final List<List<Widget>> webRows = [];
    for (int i = 0; i < confirmIdxs.length; i++) {
      mobileRows.add(
        ConfirmationTextField(
          idx: confirmIdxs[i],
          word: mnemonicWordsList[confirmIdxs[i]],
        ),
      );
      webRowChildren.add(
        ConfirmationTextField(
          idx: confirmIdxs[i],
          word: mnemonicWordsList[confirmIdxs[i]],
        ),
      );
      if ((i + 1) % 2 == 0) {
        webRows.add(webRowChildren);
        webRowChildren = [];
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: kIsWeb
          ? [
              ...List.generate(
                webRows.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: kIsWeb ? 20 : 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: webRows[index],
                  ),
                ),
              )
            ]
          : mobileRows,
    );
  }
}

class ConfirmationTextField extends HookWidget {
  final int idx;
  final String word;
  const ConfirmationTextField({
    required this.idx,
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: kIsWeb ? 20 : 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Word ${idx + 1}',
              style: RibnToolkitTextStyles.h3.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: textController,
              hintText: Strings.typeSomething,
              inputFormatters: [LowerCaseTextFormatter()],
              validator: (String? text) {
                if (text == null || text.isEmpty || text != word) {
                  return 'Please enter word';
                } else if (text != word) {
                  return 'Word does not match';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
