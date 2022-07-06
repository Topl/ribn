import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';

class OnboardingContainer extends StatelessWidget {
  final Widget child;
  const OnboardingContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topPadding = kIsWeb ? 50 : MediaQuery.of(context).size.height * 0.12;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[RibnColors.tertiary, RibnColors.primaryOffColor],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
        child: child,
      ),
    );
  }
}
