import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/settings_container.dart';
import 'package:ribn/widgets/ribn_app_bar.dart';

/// Builds the settings page.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      builder: (BuildContext context, SettingsViewModel vm) => Scaffold(
        appBar: const RibnAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitleContainer(),
              _buildSettingsListItems(vm),
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

  Widget _buildTitleContainer() {
    return Container(
      constraints: const BoxConstraints.expand(height: 90),
      color: RibnColors.accent,
      child: Stack(
        children: [
          const Center(
            child: Text(
              Strings.settings,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Spectral',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            right: 25,
            top: 25,
            child: IconButton(
              padding: EdgeInsets.zero,
              color: Colors.grey,
              constraints: const BoxConstraints(maxHeight: 16, maxWidth: 16),
              onPressed: () => Keys.navigatorKey.currentState!.pop(),
              icon: SvgPicture.asset(RibnAssets.closeGreyIcon),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the list of items on the settings page.
  Widget _buildSettingsListItems(SettingsViewModel vm) {
    return Container(
      color: RibnColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRibnVersionDescription(),
            _buildDivider(),
            _buildLinks(),
            _buildDivider(),
            _buildExportKeyStore(vm.exportKeyStore),
            _buildDivider(),
            _buildDeleteWallet(vm.deleteWallet),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRibnVersionDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          Strings.ribnVersion,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.defaultText,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '0.0.1',
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'Poppins',
            color: Color(0xFF585858),
          ),
        ),
      ],
    );
  }

  Widget _buildLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          Strings.links,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.defaultText,
          ),
        ),
        SizedBox(height: 5),
        Text(
          Strings.privacyPolicy,
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.primary,
          ),
        ),
        SizedBox(height: 5),
        Text(
          Strings.termsOfUse,
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildExportKeyStore(VoidCallback exportKeyStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.exportKeyStore,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.defaultText,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          Strings.exportKeyStoreDesc,
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'Poppins',
            color: Color(0xFF585858),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 80,
          height: 22,
          child: MaterialButton(
            color: RibnColors.primary,
            elevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: exportKeyStore,
            child: const Text(
              Strings.export,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Delete wallet
  Widget _buildDeleteWallet(VoidCallback deleteWallet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.dangerZone,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Color(0xFFd05b48),
          ),
        ),
        const SizedBox(height: 10),
        DottedBorder(
          color: const Color(0xFFff7a42),
          radius: const Radius.circular(4),
          padding: EdgeInsets.zero,
          child: Container(
            color: Colors.transparent,
            width: 290,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.actionNotReversible,
                    style: TextStyle(
                      fontSize: 9.3,
                      fontFamily: 'Poppins',
                      color: Color(0xFF585858),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 92,
                    height: 22,
                    child: OutlinedButton(
                      onPressed: deleteWallet,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: const BorderSide(
                          color: Color(0xFF585858),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        Strings.deleteWallet,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFf585858),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
