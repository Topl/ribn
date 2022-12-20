// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';

class OnboardingContainer extends StatelessWidget {
  final Widget child;
  final bool isXsScreenSize;

  const OnboardingContainer({
    Key? key,
    required this.child,
    this.isXsScreenSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topPadding =
        kIsWeb ? 50 : MediaQuery.of(context).size.height * 0.12;
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
        padding: EdgeInsets.only(
            top: topPadding,
            left: isXsScreenSize ? 10 : 20,
            right: isXsScreenSize ? 10 : 20),
        child: child,
      ),
    );
  }
}
