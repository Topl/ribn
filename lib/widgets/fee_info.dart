import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font11_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';

/// A widget that displays the fee info during the transfer flows in Ribn.
class FeeInfo extends StatelessWidget {
  const FeeInfo({required this.fee, Key? key}) : super(key: key);
  final num fee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RibnH4TextWidget(
          text: Strings.totalTxFee,
          textAlignment: TextAlign.justify,
          textColor: RibnColors.defaultText,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 5,
        ),
        RibnFont11TextWidget(
          text: '$fee POLY',
          textAlignment: TextAlign.justify,
          textColor: RibnColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
