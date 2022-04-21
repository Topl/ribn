import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// The final page during onboarding.
/// Directs user to open the Ribn extension.
class ExtensionInfoPage extends StatelessWidget {
  const ExtensionInfoPage({Key? key}) : super(key: key);
  final double inlineIconHeight = 18;
  final double inlineIconWidth = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 85.0, horizontal: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  RibnAssets.logoIcon,
                  width: 56,
                  height: 56,
                ),
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
                    child: SvgPicture.asset(RibnAssets.logoIcon, height: inlineIconHeight, width: inlineIconWidth),
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
