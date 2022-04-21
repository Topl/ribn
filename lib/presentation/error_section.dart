import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// A generic error section that is displayed in case of unexpected errors.
class ErrorSection extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorSection({
    Key? key,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(RibnAssets.errorFace),
        SizedBox(
          width: 275,
          height: 64,
          child: Text(
            Strings.errorTitle,
            style: RibnToolkitTextStyles.extH2.copyWith(
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: 262,
          height: 133,
          child: Text(
            Strings.errorDescription,
            style: RibnToolkitTextStyles.smallBody.copyWith(
              fontSize: 15,
              height: 1,
            ),
          ),
        ),
        LargeButton(
          backgroundColor: RibnColors.primary.withOpacity(0.19),
          onPressed: () async {
            await launch(Strings.supportEmailLink);
          },
          buttonChild: Text(
            Strings.contactSupport,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: RibnColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        LargeButton(
          backgroundColor: RibnColors.primary,
          onPressed: onTryAgain,
          buttonChild: Text(
            Strings.tryAgain,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
