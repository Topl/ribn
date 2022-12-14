import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/settings_container.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/settings/sections/biometrics_section.dart';
import 'package:ribn/presentation/settings/sections/delete_wallet_section.dart';
import 'package:ribn/presentation/settings/sections/export_topl_main_key_section.dart';
import 'package:ribn/presentation/settings/sections/links_section.dart';
import 'package:ribn/presentation/settings/sections/ribn_version_section.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

/// The settings page of the application.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isBioSupported = false;

  bool canDisconnect = false;

  late VoidCallback onUpdated;

  @override
  initState() async {
    if (!kIsWeb) {
      runBiometrics();
    } else {
      final List<String> dApps = await PlatformUtils.instance
          .convertToFuture(PlatformUtils.instance.getDAppList());
      await PlatformUtils.instance.consoleLog(dApps.toString());
      setState(() async {
        canDisconnect = dApps.isNotEmpty;
      });
    }
    super.initState();
  }

  runBiometrics() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    final bool isBioAuthenticationSupported =
        await isBiometricsAuthenticationSupported(_localAuthentication);

    setState(() {
      isBioSupported = isBioAuthenticationSupported ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            kIsWeb ? _buildDivider() : const SizedBox(),
            kIsWeb
                ? ExportToplMainKeySection(
                    onExportPressed: vm.exportToplMainKey,
                  )
                : const SizedBox(),
            isBioSupported ? _buildDivider() : const SizedBox(),
            isBioSupported
                ? BiometricsSection(isBiometricsEnabled: vm.isBiometricsEnabled)
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
}
