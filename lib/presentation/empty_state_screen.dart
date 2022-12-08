import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font14_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font19_text_widget.dart';

class EmptyStateScreen extends StatelessWidget {
  final String icon;
  final String title;
  final dynamic body;
  final String buttonOneText;
  final void Function() buttonOneAction;
  final String buttonTwoText;
  final void Function() buttonTwoAction;
  final dynamic mobileHeight;
  final dynamic desktopHeight;

  const EmptyStateScreen({
    required this.icon,
    required this.title,
    required this.body,
    required this.buttonOneText,
    required this.buttonOneAction,
    required this.buttonTwoText,
    required this.buttonTwoAction,
    required this.mobileHeight,
    required this.desktopHeight,
    Key? key,
  }) : super(key: key);

  final double buttonWidth = 130;
  final double buttonHeight = 35;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 24, right: 24),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: RibnColors.paleGreen,
          boxShadow: [
            BoxShadow(
                color: RibnColors.paleGreen.withOpacity(1),
                blurRadius: 8,
                spreadRadius: 8,)
          ],
        ),
        width: width - 20,
        height: kIsWeb ? desktopHeight : mobileHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 8),
            Image.asset(
              icon,
              width: kIsWeb ? 53 : 63,
            ),
            const SizedBox(height: 8),
            SizedBox(
                width: 275,
                height: 64,
                child: RibnFont19TextWidget(
                  text: title,
                  textAlignment: TextAlign.start,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1,
                ),),
            SizedBox(
              width: 275,
              height: 60,
              child: body,
            ),
            Wrap(
              children: [
                LargeButton(
                  buttonWidth: buttonWidth,
                  buttonHeight: buttonHeight,
                  backgroundColor: RibnColors.primary,
                  onPressed: buttonOneAction,
                  buttonChild: RibnFont14TextWidget(
                    text: buttonOneText,
                    textAlignment: TextAlign.start,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20),
                LargeButton(
                  buttonWidth: buttonWidth,
                  buttonHeight: buttonHeight,
                  borderColor: const Color(0xff165867),
                  backgroundColor: Colors.transparent,
                  dropShadowColor: Colors.transparent,
                  onPressed: buttonTwoAction,
                  buttonChild: RibnFont14TextWidget(
                    text: buttonTwoText,
                    textAlignment: TextAlign.start,
                    textColor: RibnColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
