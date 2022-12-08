import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h1_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h3_text_widget.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ribnLogo(50),
                const SizedBox(width: 12),
                const RibnH3TextWidget(
                  text: Strings.ribnWallet,
                  textAlignment: TextAlign.justify,
                  textColor: RibnColors.lightGreyTitle,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 50),
            const RibnH1TextWidget(
              text: Strings.openTheWalletBy,
              textColor: RibnColors.lightGreyTitle,
              fontWeight: FontWeight.w500,
              textAlignment: TextAlign.left,
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
                    child: SvgPicture.asset(RibnAssets.extensionIcon,
                        height: inlineIconHeight, width: inlineIconWidth,),
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
