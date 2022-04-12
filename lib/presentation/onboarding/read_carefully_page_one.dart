import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// Builds checks to ensure that the user understands the importance of the seed phrase.
class ReadCarefullyPageOne extends StatefulWidget {
  const ReadCarefullyPageOne({Key? key}) : super(key: key);

  @override
  State<ReadCarefullyPageOne> createState() => _ReadCarefullyPageState();
}

class _ReadCarefullyPageState extends State<ReadCarefullyPageOne> {
  bool pointOneChecked = false;
  bool pointTwoChecked = false;
  final Color barrierColor = const Color(0xb538726c);
  void onBackPressed() => Keys.navigatorKey.currentState!.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OnboardingAppBar(onBackPressed: onBackPressed),
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 25),
            child: Center(
              child: SizedBox(
                width: 700,
                height: 55,
                child: Text(
                  Strings.readCarefully,
                  style: RibnTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SvgPicture.asset(RibnAssets.warningIcon),
          const SizedBox(height: 40),
          SizedBox(
            width: 650,
            child: Column(
              children: [
                _buildCheckListTile(
                  Strings.readCarefullyPointOne,
                  pointOneChecked,
                  (bool? val) {
                    setState(() {
                      pointOneChecked = val ?? false;
                    });
                  },
                ),
                _buildCheckListTile(
                  Strings.readCarefullyPointTwo,
                  pointTwoChecked,
                  (bool? val) {
                    setState(() {
                      pointTwoChecked = val ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          ContinueButton(
            Strings.iUnderstand,
            () async => await _showRecommendationDialog(),
            disabled: !pointOneChecked || !pointTwoChecked,
          )
        ],
      ),
    );
  }

  Widget _buildCheckListTile(String label, bool checked, Function(bool?)? onChecked) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: checked ? RibnColors.active : RibnColors.inactive),
            ),
            constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
            child: Checkbox(
              fillColor: MaterialStateProperty.all(Colors.transparent),
              checkColor: RibnColors.active,
              value: checked,
              onChanged: onChecked,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Text(
              label,
              style: RibnTextStyles.body1.copyWith(color: checked ? RibnColors.defaultText : RibnColors.inactive),
              textAlign: TextAlign.start,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the popup dialog to provide recommendations on how to record the seed phrase safely
  Future<void> _showRecommendationDialog() async {
    await showGeneralDialog(
      barrierDismissible: false,
      barrierColor: barrierColor,
      pageBuilder: (context, _, __) => AlertDialog(
        backgroundColor: RibnColors.accent,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Stack(
          children: [
            Positioned(
              right: 20,
              top: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.grey,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset(RibnAssets.closeGreyIcon),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20, left: 100, right: 100),
              child: SizedBox(
                height: 67,
                width: 497,
                child: Center(
                  child: Text(
                    Strings.weRecommend,
                    style: RibnTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              Strings.weRecommendSub,
              style: RibnTextStyles.body1,
              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 500,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(width: 25, child: SvgPicture.asset(RibnAssets.paperPenIcon)),
                    const SizedBox(width: 15),
                    const Text(
                      Strings.paperAndPen,
                      style: RibnTextStyles.body1,
                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: SizedBox(
                width: 500,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(width: 25, child: SvgPicture.asset(RibnAssets.passwordManagerIcon)),
                    const SizedBox(width: 15),
                    const Text(
                      Strings.securePasswordManager,
                      style: RibnTextStyles.body1,
                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: SizedBox(
                width: 500,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(width: 25, child: SvgPicture.asset(RibnAssets.encryptFileIcon)),
                    const SizedBox(width: 15),
                    const Text(
                      Strings.encryptTextFile,
                      style: RibnTextStyles.body1,
                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        elevation: 2,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 40),
            child: ContinueButton(Strings.letsGo, () {
              Keys.navigatorKey.currentState!.pop();
              StoreProvider.of<AppState>(context).dispatch(GenerateMnemonicAction());
            }),
          )
        ],
      ),
      transitionBuilder: (context, _, __, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: child,
      ),
      context: context,
    );
  }
}
