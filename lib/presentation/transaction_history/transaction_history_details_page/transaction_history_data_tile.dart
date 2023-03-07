// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';

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
      constraints: reducedWidth == true ? const BoxConstraints(minWidth: 70) : const BoxConstraints(minWidth: 163),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tileTitle,
            style: RibnToolkitTextStyles.hintStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          tileValue,
        ],
      ),
    );
  }
}
