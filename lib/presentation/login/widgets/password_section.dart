import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

class PasswordSection extends StatelessWidget {
  const PasswordSection({Key? key, required this.baseWidth, required this.controller, this.onSubmitted})
      : super(key: key);

  final double baseWidth;
  final Function? onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: baseWidth,
        child: Wrap(
          children: [
            Text(
              Strings.enterWalletPassword,
              style: RibnToolkitTextStyles.h3.copyWith(
                color: Colors.white,
                fontSize: kIsWeb ? 13 : 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomToolTip(
                borderColor: Border.all(color: const Color(0xffE9E9E9)),
                offsetPositionLeftValue: 160,
                toolTipIcon: Image.asset(
                  RibnAssets.greyHelpBubble,
                  width: 18,
                  color: Colors.white,
                ),
                toolTipChild: const Text(
                  Strings.loginPasswordInfo,
                  style: RibnToolkitTextStyles.toolTipTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      PasswordTextField(
        onSubmitted: onSubmitted,
        hintText: Strings.typeSomething,
        controller: controller,
      ),
    ]);
  }
}
