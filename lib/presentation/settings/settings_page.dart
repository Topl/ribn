// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/danger_container_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/disconnect_dapps_section.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn/providers/settings_page_provider.dart';
import 'package:ribn/providers/utility_provider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/loading_spinner.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

import '../../providers/biometrics_provider_alt.dart';

/// The settings page of the application.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final isBiometricsSupported = ref.watch(biometricsSupportedProvider);
    final canDisconnectDApp = ref.watch(canDisconnectDAppsProvider);
    final settings = ref.watch(settingsProvider);
    final biometrics = ref.watch(biometricsProvider);
    final appVersion = ref.read(appVersionProvider);


    return Container(
        color: RibnColors.background,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RibnVersionSection(appVersion: appVersion),
                  divider,
                  const LinksSection(),
                  divider,
                  isBiometricsSupported.when(
                      data: (data) => data
                          ? biometricsSection(biometrics)
                          : const SizedBox(),
                      error: (_, __) => Container(),
                      loading: () => Container()),
                  divider,
                  DangerContainerSection(children: [
                    //Disconnect DApps
                    canDisconnectDApp.when(
                        data: (data) => data
                            ? DisconnectDAppsSection(
                                onDisconnectPressed:
                                    settings.onDisconnectPressed,
                                canDisconnect: data)
                            : Container(),
                        error: (_, __) => Container(),
                        loading: () => Container()),
                    SizedBox(height: 10),
                    //Delete Wallet Section
                    DeleteWalletSection(
                        onDeletePressed: settings.onDeletePressed),
                  ]),
                ])));
  }

  biometricsSection(Biometrics biometrics) {
    final isEnabled = biometrics.isEnabled;
    if (isEnabled == null)
      return Container(height: 20, width: 20, child: LoadingSpinner());

    return BiometricsSection(isBiometricsEnabled: isEnabled);
  }

  final divider = const Divider(height: 32);
}
