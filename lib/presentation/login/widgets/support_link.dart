import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget to redirect user to the support email.
class SupportLink extends StatelessWidget {
  const SupportLink({Key? key, required this.baseWidth}) : super(key: key);

  final double baseWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: baseWidth,
      child: Center(
        child: RichText(
          text: TextSpan(
            style: RibnToolkitTextStyles.h3.copyWith(
              color: Colors.white,
              fontSize: kIsWeb ? 13 : 14,
            ),
            children: [
              const TextSpan(
                text: Strings.needHelp,
              ),
              TextSpan(
                text: Strings.ribnSupport,
                style: RibnToolkitTextStyles.h3.copyWith(
                  color: RibnColors.secondary,
                  fontSize: kIsWeb ? 13 : 14,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final Uri url = Uri.parse(Strings.supportEmailLink);

                    await launchUrl(url);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
