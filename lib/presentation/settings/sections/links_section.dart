// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/utils/url_utils.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

/// The section for displaying helpful links.
class LinksSection extends HookConsumerWidget {
  const LinksSection({Key? key}) : super(key: key);
  final TextStyle linkStyle = const TextStyle(
    fontSize: 10.5,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w500,
    color: RibnColors.primary,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            recognizer: TapGestureRecognizer()..onTap = () async => await launchPrivacyPolicyUrl(ref),
            style: linkStyle,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: Strings.termsOfUse,
            recognizer: TapGestureRecognizer()..onTap = () async => await launchTermsOfUse(ref),
            style: linkStyle,
          ),
        ),
      ],
    );
  }
}
