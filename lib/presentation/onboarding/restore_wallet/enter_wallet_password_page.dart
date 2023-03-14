// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/warning_section.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/providers/restore_wallet_provider.dart';

/// Allows the user to enter their wallet password to decrypt the Topl Key in [toplKeyStoreJson].
class EnterWalletPasswordPage extends HookConsumerWidget {
  final String toplKeyStoreJson;

  const EnterWalletPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  final double maxWidth = 734;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _passwordController = useTextEditingController();
    final _failedToRestoreWallet = useState(false);

    final restoreWalletNotifier = ref.watch(restoreWalletProvider.notifier);
    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 1, numSteps: 2)),
              const Text(
                Strings.restoreWallet,
                style: RibnToolkitTextStyles.onboardingH1,
                textAlign: TextAlign.center,
              ),
              // warning section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: WarningSection(),
              ),
              _buildEnterWalletPassword(_passwordController),

              const SizedBox(height: 50),
              ConfirmationButton(
                text: Strings.next,
                onPressed: () async {
                  final Completer<bool> actionCompleter = Completer();
                  restoreWalletNotifier.restoreWalletWithToplKey(
                    toplKeyStoreJson: toplKeyStoreJson,
                    password: _passwordController.text,
                    completer: actionCompleter,
                  );
                  await actionCompleter.future.then((value) {
                    _failedToRestoreWallet.value = !value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _failedToRestoreWallet.value
                  ? const Text(
                      'Failed to restore wallet.',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnterWalletPassword(TextEditingController _passwordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.enterWalletPassword,
          style: RibnToolkitTextStyles.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: RibnColors.lightGreyTitle,
          ),
        ),
        PasswordTextField(
          controller: _passwordController,
          hintText: Strings.newWalletPassword,
          fillColor: RibnColors.whiteButtonShadow,
          width: 509,
          obscurePassword: true,
        ),
      ],
    );
  }
}
