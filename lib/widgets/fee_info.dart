import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';

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
          style: RibnTextStyles.extH4,
        ),
        Text(
          '$fee POLY',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            color: RibnColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
