import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class ExtensionInfoPage extends StatelessWidget {
  const ExtensionInfoPage({Key? key}) : super(key: key);
  final double inlineIconHeight = 18;
  final double inlineIconWidth = 15;

  @override
  Widget build(BuildContext context) {
    Widget ribnLogo(double width) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: RibnColors.lightGreyTitle,
          ),
          child: Image.asset(
            RibnAssets.newRibnLogo,
            width: width,
          ),
        );
    return Scaffold(
      body: OnboardingContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ribnLogo(50),
                const SizedBox(width: 12),
                const Text(
                  Strings.ribnWallet,
                  style: RibnToolkitTextStyles.h3,
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              Strings.openTheWalletBy,
              style: RibnToolkitTextStyles.h1,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.clickingTheIconPartOne,
                    style: RibnToolkitTextStyles.body1.copyWith(height: 1),
                  ),
                  WidgetSpan(
                    child: ribnLogo(inlineIconWidth),
                  ),
                  TextSpan(
                    text: Strings.clickingTheIconPartTwo,
                    style: RibnToolkitTextStyles.body1.copyWith(height: 1),
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(RibnAssets.extensionIcon, height: inlineIconHeight, width: inlineIconWidth),
                  ),
                  TextSpan(
                    text: Strings.clickingTheIconPartThree,
                    style: RibnToolkitTextStyles.body1.copyWith(height: 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
