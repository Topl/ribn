import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';

class ExtensionInfoPage extends StatelessWidget {
  const ExtensionInfoPage({Key? key}) : super(key: key);

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
                  style: RibnTextStyles.h3,
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              Strings.openTheWalletBy,
              style: RibnTextStyles.h1,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: Strings.clickingTheIconPartOne,
                    style: RibnTextStyles.body1,
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(RibnAssets.logoIcon, height: 18, width: 15),
                  ),
                  const TextSpan(
                    text: Strings.clickingTheIconPartTwo,
                    style: RibnTextStyles.body1,
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(RibnAssets.extensionIcon, height: 18, width: 15),
                  ),
                  const TextSpan(
                    text: Strings.clickingTheIconPartThree,
                    style: RibnTextStyles.body1,
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
