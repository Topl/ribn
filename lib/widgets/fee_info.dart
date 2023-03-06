// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

/// A widget that displays the fee info during the transfer flows in Ribn.
class FeeInfo extends StatelessWidget {
  const FeeInfo({required this.fee, Key? key}) : super(key: key);
  final num fee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.totalTxFee,
          style: RibnToolkitTextStyles.h4,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              '$fee POLY',
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 11,
                color: RibnColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Spacer(),
            // Text('${convertPolyToUsd(fee)} USD',
            //   style: const TextStyle(
            //     fontFamily: 'DM Sans',
            //     fontSize: 11,
            //     color: RibnColors.greyText,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        )
      ],
    );
  }

  // Mock function
  // String convertPolyToUsd(num poly){
  //   return (poly * 0.15).toStringAsFixed(2);
  // }
}
