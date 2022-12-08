import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';

class TransactionHistoryDataTile extends StatelessWidget {
  final bool reducedWidth;
  final String tileTitle;
  final Widget tileValue;

  const TransactionHistoryDataTile({
    this.reducedWidth = false,
    required this.tileTitle,
    required this.tileValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: reducedWidth == true
          ? const BoxConstraints(minWidth: 70)
          : const BoxConstraints(minWidth: 163),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RibnFont12TextWidget(
              text: tileTitle,
              textAlignment: TextAlign.justify,
              textColor: RibnColors.defaultText,
              fontWeight: FontWeight.w300,),
          const SizedBox(
            height: 6,
          ),
          tileValue,
        ],
      ),
    );
  }
}
