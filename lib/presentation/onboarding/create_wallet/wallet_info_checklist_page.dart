// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/utils/utils.dart';
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
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';

import 'package:ribn/providers/biometrics_provider.dart';

class WalletInfoChecklistPage extends HookConsumerWidget {
  static const walletInfoChecklistPageKey = Key('walletInfoChecklistPageKey');

  const WalletInfoChecklistPage({Key key = walletInfoChecklistPageKey}) : super(key: key);
  static const Key savedMyWalletPasswordSafelyKey = Key('savedMyWalletPasswordSafelyKey');
  static const Key toplCannotRecoverForMeKey = Key('toplCannotRecoverForMeKey');
  static const Key spAndPasswordUnrecoverableKey = Key('spAndPasswordUnrecoverableKey');
  static const Key walletInfoChecklistConfirmationButtonKey = Key('walletInfoChecklistConfirmationButtonKey');

  Future<void> runBiometrics(isBioSupported, ref) =>
      ref.watch(biometricsProvider).whenData((value) => isBioSupported.value = value.isSupported);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedMyWalletPasswordSafely = useState(false);
    final toplCannotRecoverForMe = useState(false);
    final spAndPasswordUnrecoverable = useState(false);

    final isBioSupported = useState(false);

    useEffect(() {
      BiometricsNotifier.isBiometricsEnabled(ref).then((value) {
        isBioSupported.value = value;
      });
      return null;
    }, []);

    // Use value changed for the first check box.
    // If going from true to false, then uncheck the other 2 values
    useValueChanged<bool, void>(savedMyWalletPasswordSafely.value, (oldValue, __) {
      if (!savedMyWalletPasswordSafely.value && oldValue) {
        toplCannotRecoverForMe.value = false;
        spAndPasswordUnrecoverable.value = false;
      }
    });

    // Use value changed for the second check box.
    // If going from true to false, then uncheck the last box too
    useValueChanged<bool, void>(toplCannotRecoverForMe.value, (oldValue, __) {
      if (!toplCannotRecoverForMe.value && oldValue) {
        spAndPasswordUnrecoverable.value = false;
      }
    });

    return Scaffold(
      body: OnboardingContainer(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
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
                checkboxKey: savedMyWalletPasswordSafelyKey,
                checked: savedMyWalletPasswordSafely.value,
                activeText: true,
                text: Strings.savedMyWalletPasswordSafely,
                onChanged: (bool? val) => savedMyWalletPasswordSafely.value = val ?? false,
              ),
              SizedBox(height: adaptHeight(0.03)),
              _buildCheckboxListTile(
                checkboxKey: toplCannotRecoverForMeKey,
                checked: toplCannotRecoverForMe.value,
                activeText: savedMyWalletPasswordSafely.value,
                text: Strings.toplCannotRecoverForMe,
                onChanged: savedMyWalletPasswordSafely.value
                    ? (bool? val) => toplCannotRecoverForMe.value = val ?? false
                    : null,
              ),
              SizedBox(height: adaptHeight(0.03)),
              _buildCheckboxListTile(
                checkboxKey: spAndPasswordUnrecoverableKey,
                checked: spAndPasswordUnrecoverable.value,
                activeText: toplCannotRecoverForMe.value,
                text: Strings.spAndPasswordUnrecoverable,
                onChanged: toplCannotRecoverForMe.value
                    ? (bool? val) => spAndPasswordUnrecoverable.value = val ?? false
                    : null,
                renderTooltipIcon: true,
              ),
              SizedBox(height: adaptHeight(0.1)),
              renderIfMobile(const MobileOnboardingProgressBar(currStep: 2)),
              ConfirmationButton(
                key: walletInfoChecklistConfirmationButtonKey,
                text: Strings.iUnderstand,
                onPressed: () {
                  Keys.navigatorKey.currentState?.pushNamed(
                    isBioSupported.value ? Routes.onboardingEnableBiometrics : Routes.walletCreated,
                  );
                },
                disabled: !spAndPasswordUnrecoverable.value,
              )
            ],
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
    renderTooltipIcon = false,
  }) {
    return SizedBox(
      width: kIsWeb ? 600 : 330,
      child: CheckboxWrappableText(
        checkboxKey: checkboxKey,
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
        renderTooltipIcon: renderTooltipIcon,
      ),
    );
  }
}
