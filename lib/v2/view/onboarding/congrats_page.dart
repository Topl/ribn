import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/v2/core/constants/assets.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/extensions/build_context_extensions.dart';
import 'package:ribn/v2/view/widgets/ribn_button.dart';

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
                      //TODO: Inset Home route
                      context.pushReplacementNamed("HOME");
                    }))
          ],
        ),
      ),
    );
  }
}
