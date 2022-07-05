import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/check_box.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// Builds checks to ensure that the user understands the importance of the seed phrase.
class SeedPhraseInfoChecklistPageMobile extends StatefulWidget {
  const SeedPhraseInfoChecklistPageMobile({Key? key}) : super(key: key);

  @override
  State<SeedPhraseInfoChecklistPageMobile> createState() => _SeedPhraseInfoChecklistPageMobileState();
}

class _SeedPhraseInfoChecklistPageMobileState extends State<SeedPhraseInfoChecklistPageMobile> {
  /// Checkboxes and their corresponding checked value
  final Map<String, bool> checkboxesState = {
    Strings.neverShareMySeedPhrase: false,
    Strings.walletRecoveryUsingSeedPhrase: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: OnboardingPagePadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.readCarefully,
                  style: RibnToolkitTextStyles.h1.copyWith(
                    color: RibnColors.lightGreyTitle,
                    fontSize: 28,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 45),
                  child: Image.asset(RibnAssets.warningPng, width: 76),
                ),
                _buildCheckboxListTile(
                  checked: checkboxesState[Strings.neverShareMySeedPhrase]!,
                  activeText: true,
                  text: Strings.neverShareMySeedPhrase,
                  onChanged: (bool? val) => onChecked(val ?? false, Strings.neverShareMySeedPhrase),
                ),
                const SizedBox(height: 40),
                _buildCheckboxListTile(
                  checked: checkboxesState[Strings.walletRecoveryUsingSeedPhrase]!,
                  activeText: checkboxesState[Strings.neverShareMySeedPhrase]!,
                  text: Strings.walletRecoveryUsingSeedPhrase,
                  onChanged: checkboxesState[Strings.neverShareMySeedPhrase]!
                      ? (bool? val) => onChecked(val ?? false, Strings.walletRecoveryUsingSeedPhrase)
                      : null,
                ),
                kIsWeb ? const SizedBox(height: 150) : const Spacer(),
                ConfirmationButton(
                  text: Strings.iUnderstand,
                  onPressed: () => navigateToRoute(context, Routes.seedPhraseInstructions),
                  disabled: checkboxesState.containsValue(false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxListTile({
    required bool checked,
    required bool activeText,
    required String text,
    required Function(bool?)? onChanged,
  }) {
    return SizedBox(
      width: kIsWeb ? 600 : 350,
      child: CheckboxWrappableText(
        fillColor: Colors.transparent,
        checkColor: const Color(0xff80FF00),
        borderColor: checked
            ? const Color(0xff80FF00)
            : activeText
                ? RibnColors.lightGreyTitle
                : RibnColors.inactive,
        value: checked,
        onChanged: onChanged,
        wrappableText: text,
        activeText: activeText,
        wrapText: true,
      ),
    );
  }

  void onChecked(bool val, String key) {
    setState(() {
      // Uncheck all checkboxes underneath if unselected
      if (!val) {
        bool shouldUncheck = false;
        checkboxesState.keys.toList().forEach((element) {
          if (element == key) shouldUncheck = true;
          if (shouldUncheck) checkboxesState[element] = false;
        });
      } else {
        checkboxesState[key] = true;
      }
    });
  }
}
