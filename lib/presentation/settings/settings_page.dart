import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/settings_container.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/export_topl_main_key_section.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';

/// The settings page of the application.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      builder: (BuildContext context, SettingsViewModel vm) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomPageTitle(
                title: Strings.settings,
                hideBackArrow: true,
              ),
              _buildSettingsListItems(vm, context),
            ],
          ),
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

  /// Builds the list of items on the settings page.
  Widget _buildSettingsListItems(SettingsViewModel vm, BuildContext context) {
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
            _buildDivider(),
            ExportToplMainKeySection(onExportPressed: vm.exportToplMainKey),
            _buildDivider(),
            BiometricsSection(isBiometricsEnabled: vm.isBiometricsEnabled),
            _buildDivider(),
            DeleteWalletSection(onDeletePressed: vm.onDeletePressed),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
