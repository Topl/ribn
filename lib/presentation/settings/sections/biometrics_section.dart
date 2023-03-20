// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:app_settings/app_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/logger_provider.dart';

/// The section allows for users to toggle biometrics authentication on/off.
class BiometricsSection extends ConsumerWidget {
  BiometricsSection({
    Key? key,
  }) : super(key: key);

  Future<void> runBiometrics(BuildContext context, WidgetRef ref, bool value) async {
    final notifier = ref.read(biometricsProvider.notifier);

    if (!await notifier.isBiometricsAuthenticationEnrolled()) return;

    try {
      final authorized = await notifier.authenticateWithBiometrics();
      notifier.setAuthorization(authorized);

      if (!authorized) {
        // TODO: add some kind of UX feature to let the user know this failed

        ref.read(loggerProvider).log(
              logLevel: LogLevel.Info,
              loggerClass: LoggerClass.Authentication,
              message: 'Biometrics Identity not recognized',
            );
        return;
      }
      notifier.toggleBiometrics();
    } catch (e) {
      if (Platform.isAndroid) await _showMyDialog(context);
      return;
    }
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
    final biometrics = ref.watch(biometricsProvider);

    return biometrics.when(
        error: (_, __) => const SizedBox(),
        loading: () => const SizedBox(),
        data: (data) => data.isSupported
            ? Column(
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
                          runBiometrics(context, ref, value);
                        },
                        value: data.isEnabled),
                  ),
                ],
              )
            : const SizedBox());
  }
}
