// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/providers/onboarding_provider.dart';
import 'package:ribn/v2/view/widgets/pin_input.dart';

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

    final focusNode = useFocusNode();
    final isPinValid = useState(false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.createPin,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h2.copyWith(
                  // color: RibnColors.lightGreyTitle,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 20),
          Text(
            Strings.createPinDisclaimer,
            textAlign: TextAlign.left,
            style: RibnTextStyle.h3.copyWith(color: RibnColors.greyText),
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
                notifier.navigate(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
