// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:ribn/v2/core/constants/assets.dart';
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/providers/biometrics_provider.dart';
import 'package:ribn/v2/view/widgets/ribn_button.dart';

class BiometricsModal extends HookConsumerWidget {
  static const biometricsModalAgreeKey = Key('biometricsModalAgreeKey');
  static const biometricsModalDisagreeKey = Key('biometricsModalDisagreeKey');

  BiometricsModal({
    Key? key,
  }) : super(key: key);

  final subTextStyle = RibnTextStyle.h3.copyWith(color: RibnColors.greyText);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(biometricsProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(Icons.close, color: RibnColors.greyedOut),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Spacer(),
        SvgPicture.asset(
          Assets.fingerprint,
          semanticsLabel: Strings.semanticFingerprint,
        ),
        SizedBox(height: 70),
        Text(Strings.enableFingerprint,
            textAlign: TextAlign.center,
            style: RibnTextStyle.h1.copyWith(
                // color: RibnColors.lightGreyTitle,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 20),
        Text(
          Strings.enableFingerprintDisclaimer,
          textAlign: TextAlign.center,
          style: subTextStyle,
        ),
        SizedBox(height: 90),
        RibnButton(
          text: Strings.enableFingerprint,
          key: biometricsModalDisagreeKey,
          onPressed: () {
            notifier.toggleBiometrics(overrideValue: true);
          },
        ),
        SizedBox(height: 15),
        Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () => {},
                child: Text(Strings.skipNow,
                    style: RibnTextStyle.buttonMedium.copyWith(
                      color: RibnColors.defaultText,
                      fontWeight: FontWeight.w500,
                    )))),
      ]),
    );
  }
}
