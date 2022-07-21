import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';

/// The section that allows for downloading the Topl Main Key.
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

  @override
  Widget build(BuildContext context) {
    /// True if biometrics authentication is completed successfully
    bool _authorized = false;

    Future<void> runBiometrics(value) async {
      bool authenticated = false;
      await isBiometricsAuthenticationSupportedAndEnrolled(_localAuthentication);

      try {
        authenticated = await authenticateWithBiometrics(_localAuthentication);
      } catch (e) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              Strings.enableBiometrics,
              style: RibnToolkitTextStyles.extH3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                Platform.isIOS ? RibnAssets.iosBiometricsOutline : RibnAssets.andriodBiometricsOutline,
                width: 40,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: Text(
            Strings.enableBiometricsDescription,
            style: RibnToolkitTextStyles.settingsSmallText,
          ),
        ),
        Transform.scale(
          alignment: Alignment.centerLeft,
          scale: 0.7,
          child: CustomToggle(
            onChanged: (value) {
              runBiometrics(value).then(
                (value) => {if (_authorized) Keys.navigatorKey.currentState?.pushNamed(Routes.home)},
              );
            },
            value: widget.isBiometricsEnabled,
          ),
        ),
      ],
    );
  }
}
