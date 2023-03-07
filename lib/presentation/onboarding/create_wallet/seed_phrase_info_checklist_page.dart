// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';

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

/// Builds checks to ensure that the user understands the importance of the seed phrase.
class SeedPhraseInfoChecklistPage extends HookWidget {
  static const Key seedPhraseInfoChecklistPageKey = Key('seedPhraseInfoChecklistPageKey');
  static const Key seedPhraseInfoChecklistConfirmationButtonKey = Key('seedPhraseInfoChecklistConfirmationButtonKey');
  static const Key neverShareMySeedPhraseKey = Key('neverShareMySeedPhraseKey');
  static const Key walletRecoveryUsingSeedPhraseKey = Key('walletRecoveryUsingSeedPhraseKey');

  const SeedPhraseInfoChecklistPage({Key key = seedPhraseInfoChecklistPageKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Checkboxes and their corresponding checked value
    final neverShareMySeedPhrase = useState(false);
    final walletRecoveryUsingSeedPhrase = useState(false);

    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderIfWeb(const WebOnboardingAppBar()),
                const Text(
                  Strings.readCarefully,
                  style: RibnToolkitTextStyles.onboardingH1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 45),
                  child: Image.asset(RibnAssets.warningPng, width: 76),
                ),
                _buildCheckboxListTile(
                  checked: neverShareMySeedPhrase.value,
                  activeText: true,
                  text: Strings.neverShareMySeedPhrase,
                  onChanged: (bool? val) => neverShareMySeedPhrase.value = val ?? false,
                  checkboxKey: neverShareMySeedPhraseKey,
                ),
                const SizedBox(height: 40),
                _buildCheckboxListTile(
                  checked: walletRecoveryUsingSeedPhrase.value,
                  activeText: neverShareMySeedPhrase.value,
                  text: Strings.walletRecoveryUsingSeedPhrase,
                  onChanged: neverShareMySeedPhrase.value
                      ? (bool? val) => walletRecoveryUsingSeedPhrase.value = val ?? false
                      : null,
                  checkboxKey: walletRecoveryUsingSeedPhraseKey,
                ),
                SizedBox(height: adaptHeight(0.1)),
                ConfirmationButton(
                  key: seedPhraseInfoChecklistConfirmationButtonKey,
                  text: Strings.iUnderstand,
                  onPressed: () {
                    Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhraseInstructions);
                  },
                  disabled: !walletRecoveryUsingSeedPhrase.value || !neverShareMySeedPhrase.value,
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
    required Key checkboxKey,
  }) {
    return SizedBox(
      width: kIsWeb ? 600 : 350,
      child: CheckboxWrappableText(
        checkboxKey: checkboxKey,
        fillColor: Colors.transparent,
        checkColor: const Color(0xff80FF00),
        borderColor: checked
            ? const Color(0xff80FF00)
            : activeText
                ? RibnColors.lightGreyTitle
                : RibnColors.transparentAlternateGreyText,
        value: checked,
        onChanged: onChanged,
        wrappableText: text,
        activeText: activeText,
        wrapText: true,
      ),
    );
  }
}
