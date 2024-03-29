// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';

/// Widget to redirect user to the restore wallet flow.
class ForgetPasswordLinkSection extends StatelessWidget {
  const ForgetPasswordLinkSection({Key? key, required this.baseWidth, required this.onButtonPress}) : super(key: key);

  final double baseWidth;
  final VoidCallback onButtonPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: baseWidth,
      child: Center(
        child: RichText(
          text: TextSpan(
            style: RibnToolkitTextStyles.h3.copyWith(
              color: RibnColors.secondary,
              fontSize: kIsWeb ? 13 : 14,
            ),
            children: [
              TextSpan(
                text: Strings.forgotPassword,
                recognizer: TapGestureRecognizer()..onTap = () => onButtonPress(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
