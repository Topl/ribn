// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/v1/constants/assets.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/onboarding/widgets/onboarding_container.dart';

class ExtensionInfoPage extends StatelessWidget {
  const ExtensionInfoPage({Key? key}) : super(key: key);
  final double inlineIconHeight = 18;
  final double inlineIconWidth = 22;

  @override
  Widget build(BuildContext context) {
    Widget ribnLogo(double width) => Image.asset(
          RibnAssets.newCircleRibnLogo,
          width: width,
        );
    return Scaffold(
      body: OnboardingContainer(
        showBackButton: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ribnLogo(50),
                const SizedBox(width: 12),
                Text(
                  Strings.ribnWallet,
                  style: RibnToolkitTextStyles.h3.copyWith(
                    color: RibnColors.lightGreyTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              Strings.openTheWalletBy,
              style: RibnToolkitTextStyles.h1.copyWith(
                color: RibnColors.lightGreyTitle,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.clickingTheIconPartOne,
                    style: RibnToolkitTextStyles.body1.copyWith(
                      height: 1,
                      color: RibnColors.lightGreyTitle,
                    ),
                  ),
                  WidgetSpan(
                    child: ribnLogo(inlineIconWidth),
                  ),
                  TextSpan(
                    text: Strings.clickingTheIconPartTwo,
                    style: RibnToolkitTextStyles.body1.copyWith(
                      height: 1,
                      color: RibnColors.lightGreyTitle,
                    ),
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(
                      RibnAssets.extensionIcon,
                      height: inlineIconHeight,
                      width: inlineIconWidth,
                    ),
                  ),
                  TextSpan(
                    text: Strings.clickingTheIconPartThree,
                    style: RibnToolkitTextStyles.body1.copyWith(
                      height: 1,
                      color: RibnColors.lightGreyTitle,
                    ),
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
