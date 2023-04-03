// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/settings/sections/analytics_section.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/danger_container_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_confirmation_dialog.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/disconnect_dapps_section.dart';
import 'package:ribn/presentation/settings/sections/disconnect_wallet_confirmation_dialog.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/settings_provider.dart';
import 'package:ribn/providers/utility_provider.dart';
import 'package:ribn/utils/extensions.dart';

/// The settings page of the application.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPageTextTitle(
              title: Strings.settings,
              hideBackArrow: true,
            ),
            SettingsListItems()
          ],
        ),
      ),
    );
  }
}

/// Builds the list of items on the settings page.
class SettingsListItems extends ConsumerWidget {
  const SettingsListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canDisconnectDApp = ref.watch(canDisconnectDAppsProvider);
    final biometrics = ref.watch(biometricsProvider);
    final appVersion = ref.watch(appVersionProvider);

    return Container(
        color: RibnColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RibnVersionSection(appVersion: appVersion),
              const LinksSection(),
              AnalyticsSection(),
              if (biometrics.value?.isSupported ?? false) BiometricsSection(),
              DangerContainerSection(children: [
                //Disconnect DApps
                canDisconnectDApp.when(
                    data: (data) => data
                        ? DisconnectDAppsSection(onDisconnectPressed: _onDisconnectPressed, canDisconnect: data)
                        : Container(),
                    error: (_, __) => Container(),
                    loading: () => Container()),
                SizedBox(height: 10),
                //Delete Wallet Section
                DeleteWalletSection(onDeletePressed: (_) => onDeletePressed(_, ref)),
              ]),
            ].separator(element: const Divider(height: 32)).toList()));
  }

  void onDeletePressed(BuildContext context, ref) async {
    final settingsNotifier = ref.read(settingsProvider);

    await showDialog(
      context: context,
      builder: (context) => DeleteWalletConfirmationDialog(
        onConfirmDeletePressed: (
          String password,
          VoidCallback onIncorrectPasswordEntered,
        ) async {
          final Completer<bool> completer = Completer();
          settingsNotifier.DeleteWallet(password, completer);
          // onIncorrectPasswordEntered called if response returned is false
          await completer.future.then((value) {
            if (!value) onIncorrectPasswordEntered();
          });
        },
      ),
    );
  }

  static Future<void> _onDisconnectPressed(BuildContext context) async {
    final dApps = await PlatformUtils.instance.convertToFuture(PlatformUtils.instance.getDAppList());
    await showDialog(
      context: context,
      builder: (context) => DisconnectWalletConfirmationDialog(dApps: dApps),
    );
  }
}
