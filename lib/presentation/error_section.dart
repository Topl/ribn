// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/utils/error_handling_utils.dart';

/// A generic error section that is displayed in case of unexpected errors.
class ErrorSection extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorSection({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  final double buttonWidth = 180;
  final double buttonHeight = 35;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(RibnAssets.sadFacePng, width: 70),
        const SizedBox(
          width: 275,
          height: 64,
          child: Text(
            Strings.errorTitle,
            style: TextStyle(
              fontFamily: 'DM Sans',
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const SizedBox(
          width: 275,
          height: 133,
          child: Text(
            Strings.errorDescription,
            style: RibnToolkitTextStyles.h4,
          ),
        ),
        const SizedBox(height: 25),
        LargeButton(
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
          backgroundColor: RibnColors.primary,
          onPressed: onTryAgain,
          buttonChild: Text(
            Strings.refreshPage,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 15),
        LargeButton(
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
          borderColor: const Color(0xff165867),
          backgroundColor: RibnColors.background,
          onPressed: () async {
            await handleContactSupport();
          },
          buttonChild: Text(
            Strings.contactSupport,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: RibnColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
