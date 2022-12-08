import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font10_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font16_text_widget.dart';

/// The section that allows for downloading the Topl Main Key.
class ExportToplMainKeySection extends StatelessWidget {
  /// Callback for when export button is pressed.
  final VoidCallback onExportPressed;

  const ExportToplMainKeySection({
    required this.onExportPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RibnFont16TextWidget(
            text: Strings.exportToplMainKey,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.primary,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: RibnFont10TextWidget(
              text: Strings.exportToplMainKeyDesc,
              textAlignment: TextAlign.justify,
              textColor: RibnColors.defaultText,
              fontWeight: FontWeight.w300,),
        ),
        SizedBox(
          width: 110,
          height: 22,
          child: LargeButton(
            buttonChild: const RibnFont10TextWidget(
                text: Strings.exportWallet,
                textAlignment: TextAlign.justify,
                textColor: RibnColors.white,
                fontWeight: FontWeight.w300,),
            backgroundColor: RibnColors.primary,
            hoverColor: RibnColors.primaryButtonHover,
            dropShadowColor: RibnColors.primaryButtonShadow,
            onPressed: onExportPressed,
          ),
        ),
      ],
    );
  }
}
