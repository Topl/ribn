import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NextButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: LargeButton(
        label: Strings.next,
        onPressed: onPressed,
      ),
    );
  }
}
