// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';
import 'package:vrouter/vrouter.dart';

class CongratsPage extends StatelessWidget {
  const CongratsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Center(
              child: SvgPicture.asset(
                Assets.walletSuccess,
                height: 80,
              ),
            ),
            Text(Strings.onboardingFinish, textAlign: TextAlign.left, style: RibnTextStyle.h1),
            SizedBox(height: 20),
            Text(
              Strings.onboardingFinishSub,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h3Grey,
            ),
            SizedBox(height: 10),
            Text(
              Strings.onboardingFinishDisclaimer,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h4Grey,
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: RibnButton(
                    text: Strings.goToWallet,
                    onPressed: () {
                      context.vRouter.to('/asset_management');
                    }))
          ],
        ),
      ),
    );
  }
}
