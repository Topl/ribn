import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// A section to display important warning message when restoring wallet.
class WarningSection extends StatelessWidget {
  const WarningSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 165,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0x17e80e00),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.warning,
                style: RibnToolkitTextStyles.extH3.copyWith(color: const Color(0xffe80e00)),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: 270,
              height: 102,
              child: Text(
                Strings.restoreWalletWarning,
                style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
