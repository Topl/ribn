// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// A section to display important warning message when restoring wallet.
class WarningSection extends StatelessWidget {
  const WarningSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIsWeb ? 509 : 309,
      height: kIsWeb ? 185 : 165,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: RibnColors.greyTransparent,
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
                style: kIsWeb
                    ? RibnToolkitTextStyles.onboardingH3.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 19.5,
                      )
                    : RibnToolkitTextStyles.extH3.copyWith(color: Colors.white),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                RibnAssets.redDangerTriangle,
                width: 24,
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Center(
            child: SizedBox(
              width: kIsWeb ? 441 : 270,
              height: kIsWeb ? 92 : 102,
              child: Text(
                Strings.restoreWalletWarning,
                style: kIsWeb
                    ? RibnToolkitTextStyles.onboardingH3
                    : RibnToolkitTextStyles.smallBody
                        .copyWith(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
