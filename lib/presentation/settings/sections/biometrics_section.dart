// Dart imports:
import 'dart:io' show Platform;

// Package imports:
import 'package:app_settings/app_settings.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';

/// The section allows for users to toggle biometrics authentication on/off.
class BiometricsSection extends ConsumerWidget {
  BiometricsSection({
    required this.state,
    Key? key,
  }) : super(key: key);

  /// True if biometrics authentication is enabled
  final BiometricsState state;

  Future<void> runBiometrics(
      BuildContext context, WidgetRef ref, bool value) async {
    final notifier = ref.read(biometricsProvider.notifier);

    /*** TODO original code didn't do anything with this value, unsure of it's function or why it's here
     *  Schedule for removal?
     */
    await notifier.isBiometricsAuthenticationEnrolled();

    try {
      notifier.setAuthorization(await notifier.authenticateWithBiometrics());
    } catch (e) {
      // TODO: Figure out why only android is being handled in this case, mustafa did mention that IOS wasn't working, but my tests seem to indicate otherwise
      if (Platform.isAndroid) await _showMyDialog(context);
      return;
    }

    if (!state.authorized) return;

    notifier.toggleBiometrics();
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Biometrics authentication is not set up on your device. Please enable biometrics in your device settings.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const TextButton(
              onPressed: AppSettings.openSecuritySettings,
              child: Text('Go to settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                runBiometrics(context, ref, value);
              },
              value: state.isEnabled),
        ),
      ],
    );
  }
}
