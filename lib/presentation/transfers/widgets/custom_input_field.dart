import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';

/// A wrapper widget used for custom input fields on transfer input pages.
class CustomInputField extends StatelessWidget {
  /// Label for the input field.
  final String itemLabel;

  /// Custom widget for the input field.
  final Widget item;

  /// Padding between [itemLabel] and [item].
  final double inbetweenPadding;

  /// Bottom padding applied to this widget.
  final double bottomPadding;

  /// Optional information text used in a [CustomToolTip].
  final String? informationText;

  const CustomInputField({
    Key? key,
    required this.itemLabel,
    required this.item,
    this.inbetweenPadding = 8,
    this.bottomPadding = 8,
    this.informationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RibnH4TextWidget(
                  text: itemLabel,
                  textAlignment: TextAlign.justify,
                  textColor: RibnColors.defaultText,
                  fontWeight: FontWeight.w500,),
              informationText != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: CustomToolTip(
                        borderColor: Border.all(color: const Color(0xffE9E9E9)),
                        toolTipChild: RibnFont12TextWidget(
                            text: informationText!,
                            textAlignment: TextAlign.justify,
                            textColor: RibnColors.defaultText,
                            fontWeight: FontWeight.w300,
                         ),
                        offsetPositionLeftValue: 100,
                        toolTipIcon: Image.asset(
                          RibnAssets.greyHelpBubble,
                          width: 18,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: inbetweenPadding),
          item,
        ],
      ),
    );
  }
}
