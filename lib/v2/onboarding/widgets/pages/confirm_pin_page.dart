// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/onboarding/providers/onboarding_provider.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/pin_input.dart';

/// A "Page" to allow the user to confirm a PIN for onboarding.
/// This is intended to be used inside of a [PageView] widget.
/// Does not provide scaffolding
class ConfirmPinPage extends HookWidget {
  final String createPin;
  final TextEditingController createPinController;
  final TextEditingController confirmPinController;
  final Function(String) onCompleted;

  const ConfirmPinPage({
    required this.createPin,
    required this.createPinController,
    required this.confirmPinController,
    required this.onCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    /// Will be set to invalid when Pin does not match state password
    final isPinValid = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.confirmPin,
            textAlign: TextAlign.left,
            style: headlineLarge(context),
          ),
          SizedBox(height: 20),
          Text(
            Strings.confirmPinDisclaimer,
            textAlign: TextAlign.left,
            style: bodyMedium(context),
          ),
          SizedBox(height: 100),
          Center(
            child: PinInput(
              length: OnboardingNotifier.pinLength,
              isPinValid: isPinValid,
              controller: confirmPinController,
              validator: (value) {
                final input = value;
                if (input == null || input.length < OnboardingNotifier.pinLength) {
                  isPinValid.value = false;
                  return Strings.pinNotLongEnough;
                }

                // Check if pin matches the one created
                if (input != createPin) {
                  isPinValid.value = false;
                  return Strings.incorrectPin;
                }

                //set validator to true
                isPinValid.value = true;
                return null;
              },
              onCompleted: (value) async {
                if (isPinValid.value) {
                  focusNode.unfocus(); //unfocus the pin input

                  onCompleted(value);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
