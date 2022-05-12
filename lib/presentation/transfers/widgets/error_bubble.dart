import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

/// A custom container used to display error messages during tx flows.
class ErrorBubble extends StatelessWidget {
  final String errorText;
  final bool inverted;
  const ErrorBubble({required this.errorText, this.inverted = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.only(
          topRight: inverted ? Radius.zero : const Radius.circular(20),
          bottomRight: const Radius.circular(20),
          bottomLeft: const Radius.circular(15),
          topLeft: inverted ? const Radius.circular(20) : Radius.zero,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(errorText, style: RibnTextStyles.toolTipTextStyle),
    );
  }
}
