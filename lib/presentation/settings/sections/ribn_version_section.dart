import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font16_text_widget.dart';

/// The section for displaying the current Ribn version.
class RibnVersionSection extends StatelessWidget {
  /// The current app version.
  final String appVersion;

  const RibnVersionSection({
    required this.appVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RibnFont16TextWidget(
            text: Strings.ribnVersion,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.white,
            fontWeight: FontWeight.w500,),
        const SizedBox(height: 10),
        RibnFont16TextWidget(
            text: appVersion,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.greyedOut,
            fontWeight: FontWeight.w300,)
      ],
    );
  }
}
