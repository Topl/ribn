import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font10_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font16_text_widget.dart';

/// The section on the settings page that allows user to delete their wallet.
class DeleteWalletSection extends StatelessWidget {
  /// Handler for when user confirms wallet deletion.
  final Function(BuildContext context) onDeletePressed;

  const DeleteWalletSection({
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RibnFont16TextWidget(
          text: Strings.dangerZone,
          textAlignment: TextAlign.justify,
          textColor: RibnColors.redColor,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: RibnColors.redColor.withOpacity(0.09),
          ),
          width: 291,
          height: 67,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RibnFont10TextWidget(
                    text: Strings.actionNotReversible,
                    textAlignment: TextAlign.justify,
                    textColor: RibnColors.greyedOut,
                    fontWeight: FontWeight.w300,),
                const SizedBox(height: 10),
                SizedBox(
                  width: 107,
                  height: 22,
                  child: LargeButton(
                    buttonChild: const RibnFont10TextWidget(
                        text: Strings.deleteWallet,
                        textAlignment: TextAlign.justify,
                        textColor: RibnColors.primary,
                        fontWeight: FontWeight.w300,),
                    backgroundColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    dropShadowColor: Colors.transparent,
                    borderColor: RibnColors.primary,
                    onPressed: () => onDeletePressed(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
