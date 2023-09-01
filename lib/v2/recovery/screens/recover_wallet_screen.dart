import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/widgets/pages/confirm_pin_page.dart';
import 'package:ribn/v2/onboarding/widgets/pages/create_pin_page.dart';
import 'package:ribn/v2/recovery/providers/recovery_provider.dart';
import 'package:ribn/v2/recovery/widgets/type_recovery_phrase.dart';
import 'package:ribn/v2/recovery/widgets/wallet_restored.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/widgets/custom_loading_dialog.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';
import 'package:vrouter/vrouter.dart';

class RestoreWalletScreen extends ScreenConsumerWidget {
  static const restoreWalletKey = Key('restoreWalletKey');

  Future<void> showCustomDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => CustomLoadingDialog(), // Use the custom dialog widget
    );
  }

  RestoreWalletScreen({
    Key? key,
  }) : super(key: key, route: '/restore');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryState = ref.watch(recoveryProvider);
    final recoveryNotifier = ref.watch(recoveryProvider.notifier);
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    ref.watch(recoveryProvider);
    return StepperScreen(
      pages: [
        TypeRecoveryPhrase(),
        CreatePinPage(
          pin: recoveryState.pin,
          pinController: recoveryNotifier.createPinController,
          onCompleted: (pin) {
            recoveryNotifier.setPin(pin);
            stepperNotifier.navigateToPage(context);
          },
        ),
        ConfirmPinPage(
          createPin: recoveryState.pin,
          createPinController: recoveryNotifier.createPinController,
          confirmPinController: recoveryNotifier.confirmPinController,
          onCompleted: (pin) {
            recoveryNotifier.setPin(pin);
            stepperNotifier.navigateToPage(context);
          },
        ),
      ],
      onDone: () async {
        // ref.read(recoveryProvider.notifier).saveWallet();
        showCustomDialog(context);
        await Future.delayed(Duration(seconds: 3));
        context.vRouter.to('/restore');
        WalletAccessRestored().showAsModal(context);
      },
    );
  }
}
