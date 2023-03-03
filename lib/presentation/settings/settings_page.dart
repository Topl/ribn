// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/danger_container_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/disconnect_dapps_section.dart';
import 'package:ribn/presentation/settings/sections/export_topl_main_key_section.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn/providers/biometrics_provider.dart';
import 'package:ribn/providers/settings_page_provider.dart';
import 'package:ribn/providers/utility_provider.dart';
import 'package:ribn/utils/extensions.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

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
    final settings = ref.watch(settingsProvider);
    final appVersion = ref.read(appVersionProvider);
    final biometrics = ref.watch(biometricsProvider);

    return Container(
        color: RibnColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RibnVersionSection(appVersion: appVersion),
              const LinksSection(),
              if (kIsWeb) ExportToplMainKeySection(onExportPressed: settings.exportToplMainKey),
              if (biometrics.value?.isSupported ?? false) BiometricsSection(),
              DangerContainerSection(children: [
                //Disconnect DApps
                canDisconnectDApp.when(
                    data: (data) => data
                        ? DisconnectDAppsSection(onDisconnectPressed: settings.onDisconnectPressed, canDisconnect: data)
                        : Container(),
                    error: (_, __) => Container(),
                    loading: () => Container()),
                SizedBox(height: 10),
                //Delete Wallet Section
                DeleteWalletSection(onDeletePressed: settings.onDeletePressed),
              ]),
            ].separator(element: const Divider(height: 32)).toList()));
  }
}
