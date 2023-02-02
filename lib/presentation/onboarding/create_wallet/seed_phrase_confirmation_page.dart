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
  const SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final Map<int, TextEditingController> idxControllerMap = {};
    final Map<TextEditingController, bool> controllerErrorMap = {};
    // return SeedPhraseConfirmationContainer(
    //   onInit: (store) {
    //     // populate [controllers] and [hasErrors] maps
    //     store.state.onboardingState.mobileConfirmIdxs.toList().forEach((idx) {
    //       final TextEditingController controller = TextEditingController();
    //       idxControllerMap[idx] = controller;
    //       controllerErrorMap[controller] = false;
    //     });
    //   },
    //   builder: (context, vm) {
    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 1)),
              SizedBox(
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
              _buildSeedphraseConfirmationGrid(
                onboardingState.mobileConfirmIdxs,
                onboardingState.shuffledMnemonic!,
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
                  // Update errors if text entered does not match mnemonic word at specified idx
                  idxControllerMap.forEach((idx, controller) {
                    final bool wordsMatch =
                        controller.text.trim() == onboardingState.shuffledMnemonic![idx];
                    controllerErrorMap[controller] = !wordsMatch;
                  });
                  if (!controllerErrorMap.values.contains(true)) {
                    Keys.navigatorKey.currentState?.pushNamed(Routes.createPassword);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeedphraseConfirmationGrid(
    List<int> confirmIdxs,
    List mnemonicWordsList,
  ) {
    final List<Widget> mobileRows = [];
    List<Widget> webRowChildren = [];
    final List<List<Widget>> webRows = [];
    for (int i = 0; i < confirmIdxs.length; i++) {
      mobileRows.add(
        _buildConfirmationTextField(
          confirmIdxs[i],
          mnemonicWordsList[confirmIdxs[i]],
        ),
      );
      webRowChildren.add(
        _buildConfirmationTextField(
          confirmIdxs[i],
          mnemonicWordsList[confirmIdxs[i]],
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

  Widget _buildConfirmationTextField(
      int idx,
      String word,
      Map<int, TextEditingController> idxControllerMap,
      Map<TextEditingController, bool> controllerErrorMap) {
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
              controller: idxControllerMap[idx]!,
              hintText: Strings.typeSomething,
              hasError: controllerErrorMap[idxControllerMap[idx]!]!,
              inputFormatters: [LowerCaseTextFormatter()],
              onChanged: (String text) {
                if (text == word) {
                  setState(() {
                    controllerErrorMap[idxControllerMap[idx]!] = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SeedPhraseGrid extends HookWidget {
  const _SeedPhraseGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
