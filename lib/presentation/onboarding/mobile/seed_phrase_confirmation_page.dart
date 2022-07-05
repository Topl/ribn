import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/seed_phrase_confirmation_container.dart';
import 'package:ribn/presentation/onboarding/mobile/helpers.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/text_fieeeld.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

class SeedPhraseConfirmationPage extends StatefulWidget {
  const SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  @override
  State<SeedPhraseConfirmationPage> createState() => _SeedPhraseConfirmationPageState();
}

class _SeedPhraseConfirmationPageState extends State<SeedPhraseConfirmationPage> {
  final Map<int, TextEditingController> idxControllerMap = {};
  final Map<TextEditingController, bool> controllerErrorMap = {};

  @override
  Widget build(BuildContext context) {
    return SeedPhraseConfirmationContainer(
      onInit: (store) {
        // populate [controllers] and [hasErrors] maps
        store.state.onboardingState.mobileConfirmIdxs!.toList().forEach((idx) {
          final TextEditingController controller = TextEditingController();
          idxControllerMap[idx] = controller;
          controllerErrorMap[controller] = false;
        });
      },
      builder: (context, vm) {
        return Scaffold(
          body: OnboardingContainer(
            child: OnboardingPagePadding(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    SizedBox(
                      width: 185,
                      child: Text(
                        Strings.writeDownSeedPhrase,
                        style: onboardingH1.copyWith(letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(RibnAssets.penPaperPng, width: 70),
                    Padding(
                      padding: EdgeInsets.only(top: adaptHeight(0.04), bottom: adaptHeight(0.02)),
                      child: Text(
                        Strings.ensureYourWordsAreCorrect,
                        style: onboardingH3,
                      ),
                    ),
                    ...vm.mobileConfirmIdxs.map(
                      (idx) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                                CustomTextField2(
                                  controller: idxControllerMap[idx]!,
                                  hintText: Strings.typeSomething,
                                  hasError: controllerErrorMap[idxControllerMap[idx]!]!,
                                  onChanged: (String text) {
                                    if (text == vm.mnemonicWordsList[idx]) {
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
                      },
                    ).toList(),
                    const SizedBox(height: 40),
                    const OnboardingProgressBar(numSteps: 4, currStep: 1),
                    const SizedBox(height: 20),
                    ConfirmationButton(
                      text: Strings.done,
                      onPressed: () {
                        // Update errors if text entered does not match mnemonic word at specified idx
                        idxControllerMap.forEach((idx, controller) {
                          final bool wordsMatch = controller.text == vm.mnemonicWordsList[idx];
                          controllerErrorMap[controller] = !wordsMatch;
                        });
                        setState(() {});
                        if (!controllerErrorMap.values.contains(true)) {
                          navigateToRoute(context, Routes.createPassword);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
