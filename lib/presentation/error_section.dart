import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/large_button.dart';
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
            style: RibnTextStyles.extH2.copyWith(
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
            style: RibnTextStyles.smallBody.copyWith(
              fontSize: 15,
              height: 1,
            ),
          ),
        ),
        LargeButton(
          label: Strings.contactSupport,
          backgroundColor: RibnColors.primary.withOpacity(0.19),
          textColor: RibnColors.primary,
          onPressed: () async {
            await launch(Strings.supportEmailLink);
          },
        ),
        const SizedBox(height: 10),
        LargeButton(
          label: Strings.tryAgain,
          onPressed: onTryAgain,
        )
      ],
    );
  }
}
