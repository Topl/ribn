import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/containers/ribn_app_bar_container.dart';
import 'package:ribn_toolkit/widgets/organisms/ribn_app_bar.dart';

/// Builds a wrapper around the AppBar from ToplToolkit to provide ViewModel & AppBarContainer
class RibnAppBarWrapper extends StatefulWidget implements PreferredSizeWidget {
  const RibnAppBarWrapper({
    Key? key,
  })  : preferredSize = const Size.fromHeight(40),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<RibnAppBarWrapper> createState() => _RibnAppBarWrapperState();
}

class _RibnAppBarWrapperState extends State<RibnAppBarWrapper> {
  @override
  Widget build(BuildContext context) {
    return RibnAppBarContainer(
      builder: (BuildContext context, RibnAppBarViewModel vm) => RibnAppBar(
        currentNetworkName: vm.currentNetworkName,
        networks: vm.networks,
        updateNetwork: vm.updateNetwork,
        settingsOptions: vm.settingsOptions,
        selectSettingsOption: vm.selectSettingsOption,
        chevronIconLink: RibnAssets.chevronDown,
        ribnLogoIconLink: RibnAssets.newRibnLogo,
        hamburgerIconLink: RibnAssets.hamburgerMenu,
      ),
    );
  }
}
