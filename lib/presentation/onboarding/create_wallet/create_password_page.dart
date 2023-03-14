// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/utils/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/password_section.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';

import 'package:ribn/providers/onboarding_provider.dart';
import 'package:ribn/providers/password_provider.dart';
import 'package:ribn/utils/navigation_utils.dart';

// import 'package:ribn/constants/routes.dart';
// import 'package:ribn/containers/create_password_container.dart';

class CreatePasswordPage extends HookConsumerWidget {
  static const Key createPasswordPageKey = Key('createPasswordPageKey');
  static const Key createPasswordConfirmationButtonKey = Key('createPasswordConfirmationButtonKey');
  CreatePasswordPage({
    Key key = createPasswordPageKey,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return () {
        // ignore: invalid_use_of_protected_member
        _formKey.currentState?.dispose();
      };
    }, []);

    final onboardingNotifier = ref.read(onboardingProvider.notifier);
    final passwordState = ref.watch(passwordProvider);

    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: OnboardingContainer(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  renderIfWeb(const WebOnboardingAppBar(currStep: 2)),
                  SizedBox(
                    width: 200,
                    child: const Text(
                      Strings.createWalletPassword,
                      style: RibnToolkitTextStyles.onboardingH1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: adaptHeight(0.01)),
                    child: Image.asset(
                      RibnAssets.createWalletPngWithShadow,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 730,
                    child: Column(
                      children: [
                        SizedBox(
                          width: adaptWidth(0.9),
                          child: const Text(
                            Strings.createWalletPasswordDesc,
                            style: RibnToolkitTextStyles.onboardingH3,
                          ),
                        ),
                        SizedBox(height: adaptHeight(0.02)),
                        PasswordSection(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  renderIfMobile(
                    const MobileOnboardingProgressBar(currStep: 2),
                  ),
                  ConfirmationButton(
                    text: Strings.done,
                    key: createPasswordConfirmationButtonKey,
                    disabled: !passwordState.atLeast8Chars ||
                        !passwordState.passwordsMatch ||
                        !passwordState.termsOfUseChecked,
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await onboardingNotifier.createPassword(password: passwordState.password);
                      context.loaderOverlay.hide();
                      navigateToRoute(route: Routes.walletInfoChecklist);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
