import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';

/// The section that allows for downloading the Topl Main Key.
class BiometricsSection extends StatelessWidget {
  /// True if biometrics authentication is enabled
  final bool isBiometricsEnabled;

  const BiometricsSection({
    required this.isBiometricsEnabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> runBiometrics(auth, value) async {
      final bool isBioSupported = await isBiometricsAuthenticationSupported(auth);

      if (!isBioSupported) return;

      try {
        await authenticateWithBiometrics(auth);
      } catch (e) {
        return;
      }

      StoreProvider.of<AppState>(context).dispatch(
        UpdateBiometricsAction(
          isBiometricsEnabled: value,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.enableFaceId,
          style: RibnToolkitTextStyles.extH3,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6, bottom: 8),
          child: Text(
            Strings.enableFaceIdDescription,
            style: RibnToolkitTextStyles.settingsSmallText,
          ),
        ),
        CustomToggle(
          onChanged: (value) {
            final LocalAuthentication _localAuthentication = LocalAuthentication();

            runBiometrics(_localAuthentication, value).then(
              (value) => Keys.navigatorKey.currentState?.pushNamed(Routes.home),
            );
          },
          value: isBiometricsEnabled,
        ),
      ],
    );
  }
}
