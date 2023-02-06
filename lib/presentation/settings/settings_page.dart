// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Package imports:
import 'package:local_auth/local_auth.dart';
// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/settings_container.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/export_topl_main_key_section.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn/providers/settings_page_provider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

/// The settings page of the application.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsContainer(
      builder: (BuildContext context, SettingsViewModel vm) {
        vm.canDisconnect = canDisconnect;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomPageTextTitle(
                  title: Strings.settings,
                  hideBackArrow: true,
                ),
                _buildSettingsListItems(vm, context),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Builds the list of items on the settings page.
class SettingsListItems extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isBiometricsSupported = ref.watch(biometricsSupportedProvider);

    return Container(
      color: RibnColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RibnVersionSection(appVersion: vm.appVersion),
            _buildDivider(),
            const LinksSection(),
            kIsWeb ? _buildDivider() : const SizedBox(),
            kIsWeb
                ? ExportToplMainKeySection(
                    onExportPressed: vm.exportToplMainKey,
                  )
                : const SizedBox(),
            isBiometricsSupported ? _buildDivider() : const SizedBox(),
            isBiometricsSupported
                ? BiometricsSection(isBiometricsEnabled: ref.watch(biometricsEnabledProvider))
                : const SizedBox(),
            _buildDivider(),
            DeleteWalletSection(
              onDeletePressed: vm.onDeletePressed,
              onDisconnectPressed: vm.onDisconnectPressed,
              canDisconnect: canDisconnect,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds the divider intended for separating the items on the settings page.
  Widget _buildDivider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          height: 1,
          color: const Color(0xFFE9E9E9),
        ),
      );
}
