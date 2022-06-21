import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

class BottomReviewButton extends StatelessWidget {
  const BottomReviewButton({Key? key, required this.vm, required this.onPressed}) : super(key: key);

  final dynamic vm;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        height: 140,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x40E2ECF9),
              spreadRadius: 0,
              blurRadius: 37.5,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // fee info for the tx
                FeeInfo(fee: vm.networkFee),
                _buildReviewButton(vm),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildReviewButton(dynamic vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: LargeButton(
          buttonWidth: double.infinity,
          buttonChild: Text(
            Strings.review,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
