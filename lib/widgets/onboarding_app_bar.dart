import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
// import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/progress_bar.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final VoidCallback? onBackPressed;
  final int currPage;

  const OnboardingAppBar({this.onBackPressed, this.currPage = -1, Key? key})
      : preferredSize = const Size.fromHeight(100),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              onBackPressed != null
                  ? IconButton(
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
                    )
                  : const SizedBox(),
              onBackPressed != null ? const Text(Strings.back, style: RibnTextStyles.bodyTwo) : const SizedBox(),
              // const SizedBox(width: 100),
              currPage > -1
                  ? Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomProgressBar(currPage),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      foregroundColor: RibnColors.defaultText,
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      elevation: 0,
      centerTitle: false,
    );
  }
}
