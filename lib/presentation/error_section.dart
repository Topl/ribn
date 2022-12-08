import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font14_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font22_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A generic error section that is displayed in case of unexpected errors.
class ErrorSection extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorSection({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  final double buttonWidth = 180;
  final double buttonHeight = 35;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(RibnAssets.sadFacePng, width: 70),
        const SizedBox(
          width: 275,
          height: 64,
          child: RibnFont22TextWidget(
            text: Strings.errorTitle,
            textAlignment: TextAlign.start,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        const SizedBox(
          width: 275,
          height: 133,
          child: RibnH4TextWidget(
            text: Strings.errorDescription,
            textAlignment: TextAlign.start,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 25),
        LargeButton(
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
          backgroundColor: RibnColors.primary,
          onPressed: onTryAgain,
          buttonChild: const RibnFont14TextWidget(
            text: Strings.refreshPage,
            textAlignment: TextAlign.start,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 15),
        LargeButton(
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
          borderColor: const Color(0xff165867),
          backgroundColor: RibnColors.background,
          onPressed: () async {
            await launchUrlString(Strings.supportEmailLink);
          },
          buttonChild: const RibnFont14TextWidget(
            text: Strings.contactSupport,
            textAlignment: TextAlign.start,
            textColor: RibnColors.primary,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
