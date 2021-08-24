import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;
  const ContinueButton({
    Key? key,
    this.enabled = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.blue,
        disabledColor: Colors.grey,
        child: const Text("Continue"),
        onPressed: enabled ? onPressed : null);
  }
}
