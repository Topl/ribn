import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        LargeButton(
          backgroundColor: RibnColors.primary.withOpacity(0.19),
          onPressed: () async {
            final Uri url = Uri.parse(Strings.supportEmailLink);

            await launchUrl(url);
          },
          buttonChild: Text(
            Strings.refreshPage,
            style: RibnToolkitTextStyles.btnMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        LargeButton(
          backgroundColor: RibnColors.primary.withOpacity(0.19),
          onPressed: () async {
            await launchUrlString(Strings.supportEmailLink);
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
