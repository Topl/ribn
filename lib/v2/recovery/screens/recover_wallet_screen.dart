import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/recovery/providers/recovery_provider.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';

import '../../onboarding/widgets/pages/confirm_pin_page.dart';
import '../../onboarding/widgets/pages/create_pin_page.dart';
import '../../shared/extensions/screen_hook_widget.dart';
import '../widgets/type_recovery_phrase.dart';
import '../widgets/wallet_restored.dart';

class RestoreWalletScreen extends ScreenConsumerWidget {
  static const restoreWalletKey = Key('restoreWalletKey');

  RestoreWalletScreen({
    Key? key,
  }) : super(key: key, route: '/restore');

  final _pages = [TypeRecoveryPhrase(), CreatePinPage(), ConfirmPinPage()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(recoveryProvider);
    return StepperScreen(
      pages: _pages,
      onDone: () {
        WalletAccessRestored().showAsModal(context);
      },
    );
  }
}
