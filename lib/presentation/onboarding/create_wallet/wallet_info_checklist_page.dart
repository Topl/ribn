import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_created_page.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';

class WalletInfoChecklistPage extends StatefulWidget {
  const WalletInfoChecklistPage({Key? key}) : super(key: key);

  @override
  State<WalletInfoChecklistPage> createState() => _WalletInfoChecklistPageState();
}

class _WalletInfoChecklistPageState extends State<WalletInfoChecklistPage> {
  /// Checkboxes and their corresponding checked value
  final Map<String, bool> checkboxesState = {
    Strings.savedMyWalletPasswordSafely: false,
    Strings.toplCannotRecoverForMe: false,
    Strings.spAndPasswordUnrecoverable: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingContainer(
        child: Column(
          children: [
            renderIfWeb(const WebOnboardingAppBar(currStep: 2)),
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
              checked: checkboxesState[Strings.savedMyWalletPasswordSafely]!,
              activeText: true,
              text: Strings.savedMyWalletPasswordSafely,
              onChanged: (bool? val) => onChecked(val ?? false, Strings.savedMyWalletPasswordSafely),
            ),
            SizedBox(height: adaptHeight(0.03)),
            _buildCheckboxListTile(
              checked: checkboxesState[Strings.toplCannotRecoverForMe]!,
              activeText: checkboxesState[Strings.savedMyWalletPasswordSafely]!,
              text: Strings.toplCannotRecoverForMe,
              onChanged: checkboxesState[Strings.savedMyWalletPasswordSafely]!
                  ? (bool? val) => onChecked(val ?? false, Strings.toplCannotRecoverForMe)
                  : null,
            ),
            SizedBox(height: adaptHeight(0.03)),
            _buildCheckboxListTile(
              checked: checkboxesState[Strings.spAndPasswordUnrecoverable]!,
              activeText: checkboxesState[Strings.toplCannotRecoverForMe]!,
              text: Strings.spAndPasswordUnrecoverable,
              onChanged: checkboxesState[Strings.toplCannotRecoverForMe]!
                  ? (bool? val) => onChecked(val ?? false, Strings.spAndPasswordUnrecoverable)
                  : null,
            ),
            adaptableSpacer(),
            renderIfMobile(const MobileOnboardingProgressBar(currStep: 2)),
            ConfirmationButton(
              text: Strings.iUnderstand,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WalletCreatedPage()));
              },
              disabled: checkboxesState.containsValue(false),
            )
          ],
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