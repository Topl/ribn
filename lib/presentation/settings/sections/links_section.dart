import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font16_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
        const RibnFont16TextWidget(
          text: Strings.links,
          textAlignment: TextAlign.justify,
          textColor: RibnColors.secondaryDark,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
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
