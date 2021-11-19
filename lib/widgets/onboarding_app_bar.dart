import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/progress_bar.dart';

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
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  )
                : const SizedBox(),
            onBackPressed != null ? const Text(Strings.back, style: RibnTextStyles.body1Bold) : const SizedBox(),
            const Spacer(),
            showProgressBar
                ? Padding(
                    padding: const EdgeInsets.only(top: 30.0, right: 80),
                    child: CustomProgressBar(currPage),
                  )
                : const SizedBox(height: 70),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
