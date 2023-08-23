// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/pin_input.dart';

/// A "Page" to allow the user to create a PIN for onboarding.
/// This is intended to be used inside of a [PageView] widget.
/// Does not provide scaffolding
class CreatePinPage extends HookWidget {
  final String pin;
  final TextEditingController pinController;
  final Function(String) onCompleted;
  const CreatePinPage({
    required this.pin,
    required this.pinController,
    required this.onCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isPinValid = useState(false);

    bool isSafePin(int? pin) {
      List<int> unsafePins = [123456, 654321, 987654]; // Add more unsafe PINs if needed

      // Check if the input pin is in the list of unsafePins
      if (unsafePins.contains(pin)) {
        return false;
      }

      // Otherwise, the PIN is safe
      return true;
    }

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
              length: OnboardingNotifier.pinLength,
              controller: pinController,
              isPinValid: isPinValid,
              focusNode: focusNode,
              validator: (value) {
                final input = value;
                final isPinSafe = isSafePin(int.parse(input!));
                if (input.isEmpty || input.length < OnboardingNotifier.pinLength) {
                  isPinValid.value = false;
                  return Strings.pinNotLongEnough;
                }
                if (input.length >= OnboardingNotifier.pinLength && !isPinSafe) {
                  isPinValid.value = false;
                  return Strings.unsafePin;
                }
                //set validator to true
                isPinValid.value = true;
                return null;
              },
              onCompleted: (value) async {
                // if the pin is not valid, return
                if (!isPinValid.value) return;
                focusNode.unfocus(); //unfocus the pin input

                onCompleted(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
