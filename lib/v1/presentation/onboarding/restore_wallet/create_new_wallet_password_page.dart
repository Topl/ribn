// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/organisms/onboarding_progress_bar.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/onboarding/utils.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/password_section.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/warning_section.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/v1/providers/password_provider.dart';
import 'package:ribn/v1/providers/restore_wallet_provider.dart';

/// Page for creating a new wallet password, when restoring wallet with a [seedPhrase].
class NewWalletPasswordPage extends HookConsumerWidget {
  static const Key newWalletPasswordPageKey = Key('newWalletPasswordPageKey');
  static const Key newWalletPasswordConfirmationButtonKey = Key('newWalletPasswordConfirmationButtonKey');

  /// The seed phrase being used for wallet restoration.
  final String seedPhrase;

  const NewWalletPasswordPage({
    required this.seedPhrase,
    Key key = newWalletPasswordPageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordState = ref.watch(passwordProvider);
    final restoreWalletNotifer = ref.watch(restoreWalletProvider.notifier);
    return LoaderOverlay(
      child: Scaffold(
        extendBody: true,
        body: OnboardingContainer(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                renderIfWeb(
                  const WebOnboardingAppBar(currStep: 1, numSteps: 2),
                ),
                const Text(
                  Strings.restoreWallet,
                  style: RibnToolkitTextStyles.onboardingH1,
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: WarningSection(),
                ),
                SizedBox(
                  width: kIsWeb ? 370 : double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PasswordSection(),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                renderIfMobile(
                  const OnboardingProgressBar(numSteps: 2, currStep: 0),
                ),
                const SizedBox(height: 20),
                ConfirmationButton(
                  key: newWalletPasswordConfirmationButtonKey,
                  text: Strings.done,
                  disabled:
                      !passwordState.atLeast8Chars || !passwordState.passwordsMatch || !passwordState.termsOfUseChecked,
                  onPressed: () {
                    context.loaderOverlay.show();
                    restoreWalletNotifer.restoreWalletWithMnemonic(
                      password: passwordState.password,
                      mnemonic: seedPhrase,
                    );
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
