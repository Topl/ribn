import 'dart:io';
import 'dart:io' show Platform;

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font10_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font16_text_widget.dart';

/// The section allows for users to toggle biometrics authentication on/off.
class BiometricsSection extends StatefulWidget {
  /// True if biometrics authentication is enabled
  final bool isBiometricsEnabled;

  const BiometricsSection({
    required this.isBiometricsEnabled,
    Key? key,
  }) : super(key: key);

  @override
  State<BiometricsSection> createState() => _BiometricsSectionState();
}

class _BiometricsSectionState extends State<BiometricsSection> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  /// True if biometrics authentication is completed successfully
  bool _authorized = false;

  Future<void> runBiometrics(value) async {
    bool authenticated = false;
    await isBiometricsAuthenticationEnrolled(_localAuthentication);

    try {
      authenticated = await authenticateWithBiometrics(_localAuthentication);
    } catch (e) {
      if (Platform.isAndroid) await _showMyDialog();
      return;
    }

    if (!mounted || !authenticated) {
      return;
    }

    setState(() {
      _authorized = authenticated ? true : false;
    });

    StoreProvider.of<AppState>(context).dispatch(
      UpdateBiometricsAction(
        isBiometricsEnabled: value,
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                RibnFont12TextWidget(
                  text: Strings.biometricsSetupWarning,
                  textAlignment: TextAlign.justify,
                  textColor: RibnColors.defaultText,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const RibnFont12TextWidget(
                text: Strings.oK,
                textAlignment: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.normal,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const TextButton(
              child: RibnFont12TextWidget(
                text: Strings.navigateToSettings,
                textAlignment: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.normal,
              ),
              onPressed: AppSettings.openSecuritySettings,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const RibnFont16TextWidget(
              text: Strings.enableBiometrics,
              textAlignment: TextAlign.justify,
              textColor: RibnColors.defaultText,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                Platform.isIOS
                    ? RibnAssets.iosBiometricsOutline
                    : RibnAssets.andriodBiometricsOutline,
                width: 40,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: RibnFont10TextWidget(
            text: Strings.enableBiometricsDescription,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.greyedOut,
            fontWeight: FontWeight.w300,
          ),
        ),
        Transform.scale(
          alignment: Alignment.centerLeft,
          scale: 0.7,
          child: CustomToggle(
            onChanged: (value) {
              runBiometrics(value).then(
                (value) => {if (_authorized) setState(() {})},
              );
            },
            value: widget.isBiometricsEnabled,
          ),
        ),
      ],
    );
  }
}
