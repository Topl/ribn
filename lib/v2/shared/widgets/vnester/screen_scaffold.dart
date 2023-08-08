import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget child;
  const ScreenScaffold({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
