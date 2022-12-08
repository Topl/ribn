import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font15_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font18_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font20_text_widget.dart';

/// A section to display important warning message when restoring wallet.
class WarningSection extends StatelessWidget {
  const WarningSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIsWeb ? 509 : 309,
      height: kIsWeb ? 185 : 165,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: RibnColors.greyTransparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RibnFont20TextWidget(
                  text: Strings.warning,
                  textColor: RibnColors.white,
                  textAlignment: TextAlign.center,
                  fontWeight: FontWeight.w700,
                  textHeight: 1.6,),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                RibnAssets.redDangerTriangle,
                width: 24,
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          const Center(
            child: SizedBox(
              width: kIsWeb ? 441 : 270,
              height: kIsWeb ? 92 : 102,
              child: kIsWeb
                  ? RibnFont18TextWidget(
                      text: Strings.restoreWalletWarning,
                      textAlignment: TextAlign.justify,
                      textColor: RibnColors.lightGreyTitle,
                      fontWeight: FontWeight.w400,)
                  : RibnFont15TextWidget(
                      text: Strings.restoreWalletWarning,
                      textAlignment: TextAlign.justify,
                      textColor: RibnColors.white,
                      fontWeight: FontWeight.w400,),
            ),
          ),
        ],
      ),
    );
  }
}
