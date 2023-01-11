// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

/// The section for displaying helpful links.
class LinksSection extends StatelessWidget {
  const LinksSection({Key? key}) : super(key: key);
  final TextStyle linkStyle = const TextStyle(
    fontSize: 10.5,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w500,
    color: RibnColors.primary,
  );

  @override
  Widget build(BuildContext context) {
    final Uri url1 = Uri.parse(Strings.privacyPolicyUrl);
    final Uri url2 = Uri.parse(Strings.termsOfUseUrl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.links,
          style: RibnToolkitTextStyles.extH3,
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: Strings.privacyPolicy,
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await launchUrl(url1),
            style: linkStyle,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: Strings.termsOfUse,
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await launchUrl(url2),
            style: linkStyle,
          ),
        ),
      ],
    );
  }
}
