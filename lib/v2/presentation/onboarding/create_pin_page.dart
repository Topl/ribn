import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/constants/colors.dart';
import 'package:ribn/v2/constants/strings.dart';
import 'package:ribn/v2/presentation/widgets/pin_input_widget.dart';
import 'package:ribn/v2/presentation/widgets/ribn_button.dart';
import 'package:ribn/v2/presentation/widgets/step_indicator.dart';

class CreatePinPage extends HookConsumerWidget {
  const CreatePinPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState(0);

    // used to change pin success state
    final isPinValid = useState(false);
    final controller = useTextEditingController();

    final pinLength = 6;

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RibnButton(
            text: "Increment",
            onPressed: () {
              if (state.value < 3) {
                state.value++;
              } else {
                state.value = 0;
              }
              print(state.value);
            }),
        Text("${state.value}"),
        Container(
          height: 20,
          width: 40,
          child: StepIndicator(
            currentStep: state.value,
            totalSteps: 4,
            currentIndicatorColor: RibnColors.primary,
          ),
        ),
        PinInput(
           length: pinLength,
            controller: controller,
            isPinValid: isPinValid,
            validator: (value) {
              final input = value;
              if (input == null || input.length < pinLength) {
                isPinValid.value = false;
                return Strings.pinNotLongEnough;
              }
              //set validator to true
              isPinValid.value = true;
              return null;
            },
            onCompleted: (value) {
              print(value);
            },
        )
      ],
    )));
  }
}

