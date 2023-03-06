<<<<<<< HEAD
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
=======
// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/peekaboo_button.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';

// Project imports:
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
>>>>>>> rc-0.4
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
<<<<<<< HEAD
import 'package:ribn/utils/navigation_utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';
=======
>>>>>>> rc-0.4

/// This page allows the user to enter a known mnemonic / seed phrase in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated from the login page,
/// hence the widget name is prefixed with 'Login'.
class RestoreWalletPage extends HookWidget {
  static const Key restoreWalletPageKey = Key('restoreWalletPageKey');
  static const Key restoreWalletConfirmationButtonKey = Key('restoreWalletConfirmationButtonKey');
  static const Key mnemonicTextFieldKey = Key('mnemonicTextFieldKey');

  const RestoreWalletPage({Key key = restoreWalletPageKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Controller for the seed phrase text field.
    final TextEditingController controller = useTextEditingController();

    /// Seed phrase entered by the user.
    final seedPhrase = useState(controller.text);

    /// True if an invalid seed phrase is entered.
    final invalidSeedPhraseEntered = useState(false);

    useEffect(() {
      controller.addListener(() {
        seedPhrase.value = controller.text;
        invalidSeedPhraseEntered.value = false;
      });

      return () {};
    }, []);
    return Scaffold(
      extendBody: true,
      body: OnboardingContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            renderIfWeb(const WebOnboardingAppBar(currStep: 0, numSteps: 2)),
            const Text(
              Strings.restoreWallet,
              style: RibnToolkitTextStyles.onboardingH1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 700,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    Strings.restoreWalletSeedPhraseDesc,
                    style: RibnToolkitTextStyles.onboardingH3,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Strings.enterSeedPhrase,
                      style: RibnToolkitTextStyles.extH3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // seed phrase text field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      textFieldKey: mnemonicTextFieldKey,
                      width: 500,
                      height: 70,
                      controller: controller,
                      hintText: Strings.hintSeedPhrase,
                      hasError: invalidSeedPhraseEntered.value,
                    ),
                  ),
<<<<<<< HEAD

                  /// Hidden for RIBN-557
                  // kIsWeb ? Align(alignment: Alignment.centerLeft, child: _buildAdvancedOption()) : const SizedBox(),
=======
                  kIsWeb
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: _buildAdvancedOption(),
                        )
                      : const SizedBox(),
>>>>>>> rc-0.4
                ],
              ),
            ),
            adaptableSpacer(),
            renderIfMobile(
              const OnboardingProgressBar(numSteps: 2, currStep: 0),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: ConfirmationButton(
                key: restoreWalletConfirmationButtonKey,
                text: Strings.next,
                onPressed: () => onNextPressed(
                  seedPhrase,
                  context,
                  invalidSeedPhraseEntered,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handler for when [LargeButton] is pressed.
  ///
  /// Validates the seedphrase entered and if valid, navigates to the next page, i.e. [Routes.restoreWalletNewPassword].
  void onNextPressed(
    ValueNotifier<String> seedPhrase,
    BuildContext context,
    ValueNotifier<bool> invalidSeedPhraseEntered,
  ) {
    final bool isSeedPhraseValid = validateMnemonic(seedPhrase.value, 'english');
    if (isSeedPhraseValid) {
      navigateToRoute(
        route: Routes.restoreWalletNewPassword,
        arguments: seedPhrase.value,
      );
    } else {
      invalidSeedPhraseEntered.value = true;
    }
  }

<<<<<<< HEAD
  /// Hidden for RIBN-557
  // Widget _buildAdvancedOption() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 5.0),
  //     child: SizedBox(
  //       width: maxWidth,
  //       child: PeekabooButton(
  //         buttonText: Text(
  //           Strings.advancedOption,
  //           style: RibnToolkitTextStyles.smallBody
  //               .copyWith(fontSize: 15, color: RibnColors.whiteBackground),
  //         ),
  //         buttonChild: Padding(
  //           padding: const EdgeInsets.only(left: 8),
  //           child: RichText(
  //             text: TextSpan(
  //               style: RibnToolkitTextStyles.body1Bold
  //                   .copyWith(color: RibnColors.whiteBackground),
  //               children: [
  //                 const TextSpan(text: 'Use '),
  //                 TextSpan(
  //                   text: 'Topl main key file',
  //                   style: RibnToolkitTextStyles.body1Bold
  //                       .copyWith(color: RibnColors.secondaryDark),
  //                   recognizer: TapGestureRecognizer()
  //                     ..onTap = () => Keys.navigatorKey.currentState
  //                         ?.pushNamed(Routes.restoreWithToplKey),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
=======
  Widget _buildAdvancedOption() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: maxWidth,
        child: PeekabooButton(
          buttonText: Text(
            Strings.advancedOption,
            style: RibnToolkitTextStyles.smallBody
                .copyWith(fontSize: 15, color: RibnColors.whiteBackground),
          ),
          buttonChild: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: RichText(
              text: TextSpan(
                style: RibnToolkitTextStyles.body1Bold
                    .copyWith(color: RibnColors.whiteBackground),
                children: [
                  const TextSpan(text: 'Use '),
                  TextSpan(
                    text: 'Topl main key file',
                    style: RibnToolkitTextStyles.body1Bold
                        .copyWith(color: RibnColors.secondaryDark),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Keys.navigatorKey.currentState
                          ?.pushNamed(Routes.restoreWithToplKey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
>>>>>>> rc-0.4
}
