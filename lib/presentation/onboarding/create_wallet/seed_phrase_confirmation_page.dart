import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/seed_phrase_confirmation_container.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';

class SeedPhraseConfirmationPage extends StatefulWidget {
  const SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  @override
  State<SeedPhraseConfirmationPage> createState() =>
      _SeedPhraseConfirmationPageState();
}

class _SeedPhraseConfirmationPageState
    extends State<SeedPhraseConfirmationPage> {
  final Map<int, TextEditingController> idxControllerMap = {};
  final Map<TextEditingController, bool> controllerErrorMap = {};

  @override
  Widget build(BuildContext context) {
    return SeedPhraseConfirmationContainer(
      onInit: (store) {
        // populate [controllers] and [hasErrors] maps
        store.state.onboardingState.mobileConfirmIdxs.toList().forEach((idx) {
          final TextEditingController controller = TextEditingController();
          idxControllerMap[idx] = controller;
          controllerErrorMap[controller] = false;
        });
      },
      builder: (context, vm) {
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
                      style: RibnToolkitTextStyles.onboardingH1
                          .copyWith(letterSpacing: 0.5),
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
                    vm.confirmeIdxs,
                    vm.mnemonicWordsList,
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
                            controller.text.trim() == vm.mnemonicWordsList[idx];
                        controllerErrorMap[controller] = !wordsMatch;
                      });
                      setState(() {});
                      if (!controllerErrorMap.values.contains(true)) {
                        Keys.navigatorKey.currentState
                            ?.pushNamed(Routes.createPassword);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildConfirmationTextField(int idx, String word) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: kIsWeb ? 20 : 0),
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
