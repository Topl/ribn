import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

/// The section for displaying helpful links.
class LinksSection extends StatelessWidget {
  const LinksSection({Key? key}) : super(key: key);
  final TextStyle linkStyle = const TextStyle(
    fontSize: 10.5,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: RibnColors.primary,
  );

  @override
  Widget build(BuildContext context) {
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
            recognizer: TapGestureRecognizer()..onTap = () async => await launch(Strings.privacyPolicyUrl),
            style: linkStyle,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: Strings.termsOfUse,
            recognizer: TapGestureRecognizer()..onTap = () async => await launch(Strings.termsOfUseUrl),
            style: linkStyle,
          ),
        ),
      ],
    );
  }
}
