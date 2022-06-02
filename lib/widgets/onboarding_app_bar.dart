import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/widgets/organisms/progress_bar.dart';

/// Custom [AppBar] displayed during onboarding.
class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({this.onBackPressed, this.currPage = -1, Key? key})
      : showProgressBar = currPage > -1,
        super(key: key);
  final VoidCallback? onBackPressed;
  final int currPage;
  final bool showProgressBar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            const SizedBox(width: 60),
            onBackPressed != null
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      onPressed: onBackPressed,
                      icon: const Icon(Icons.arrow_back_sharp),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 9),
            onBackPressed != null
                ? const Text(
                    Strings.back,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xff333333),
                    ),
                  )
                : const SizedBox(),
            const Spacer(),
            showProgressBar
                ? Padding(
                    padding: const EdgeInsets.only(top: 30.0, right: 80),
                    child: CustomProgressBar(
                      currPage: currPage,
                      stepLabels: {
                        0: Strings.generateSeedPhrase.toUpperCase(),
                        1: Strings.writeDownSeedPhrase.toUpperCase(),
                        2: Strings.confirmSeedPhrase.toUpperCase(),
                        3: Strings.createWalletPassword.toUpperCase(),
                        4: Strings.finalReview.toUpperCase(),
                      },
                    ),
                  )
                : const SizedBox(height: 70),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
