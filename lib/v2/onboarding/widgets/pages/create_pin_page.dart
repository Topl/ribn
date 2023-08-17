// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/pin_input.dart';

/// A "Page" to allow the user to create a PIN for onboarding.
/// This is intended to be used inside of a [PageView] widget.
/// Does not provide scaffolding
class CreatePinPage extends HookConsumerWidget {
  const CreatePinPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(onboardingProvider.notifier);
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    final focusNode = useFocusNode();
    final isPinValid = useState(false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.createPin,
            textAlign: TextAlign.left,
            style: headlineLarge(context),
          ),
          SizedBox(height: 20),
          Text(
            Strings.createPinDisclaimer,
            textAlign: TextAlign.left,
            style: bodyMedium(context),
          ),
          SizedBox(height: 100),
          Center(
            child: PinInput(
              length: notifier.pinLength,
              controller: notifier.createPinController,
              isPinValid: isPinValid,
              focusNode: focusNode,
              validator: (value) {
                final input = value;
                if (input == null || input.length < notifier.pinLength) {
                  isPinValid.value = false;
                  return Strings.pinNotLongEnough;
                }
                //set validator to true
                isPinValid.value = true;
                return null;
              },
              onCompleted: (value) async {
                // if the pin is not valid, return
                if (!isPinValid.value) return;

                ref.read(onboardingProvider.notifier).setPassword(value);
                focusNode.unfocus(); //unfocus the pin input
                stepperNotifier.navigateToPage(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
