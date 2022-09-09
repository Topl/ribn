import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class TransactionHistoryDataTile extends StatelessWidget {
  final CrossAxisAlignment startOrEnd;
  final String tileTitle;
  final Widget tileValue;

  const TransactionHistoryDataTile({
    required this.startOrEnd,
    required this.tileTitle,
    required this.tileValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: startOrEnd,
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
