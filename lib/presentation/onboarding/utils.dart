import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

TextStyle onboardingH1 = RibnToolkitTextStyles.h1.copyWith(
  color: RibnColors.lightGreyTitle,
  height: 1.67,
  fontSize: 28,
);
TextStyle onboardingH3 = RibnToolkitTextStyles.h3.copyWith(
  fontSize: 18,
  height: 1.6,
  color: RibnColors.lightGreyTitle,
);

Widget adaptableSpacer() => kIsWeb ? const SizedBox(height: 150) : const Spacer();
Widget renderIfMobile(Widget widget) => kIsWeb ? const SizedBox() : widget;
Widget renderIfWeb(Widget widget) => kIsWeb ? widget : const SizedBox();
