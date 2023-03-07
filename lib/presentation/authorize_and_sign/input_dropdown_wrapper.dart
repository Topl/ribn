// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/widgets/molecules/input_dropdown.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/containers/ribn_app_bar_container.dart';

// import 'package:ribn_toolkit/widgets/organisms/ribn_app_bar.dart';

/// Builds a wrapper around the AppBar from ToplToolkit to provide ViewModel & AppBarContainer
class InputDropdownWrapper extends StatefulWidget implements PreferredSizeWidget {
  const InputDropdownWrapper({
    Key? key,
  })  : preferredSize = const Size.fromHeight(40),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<InputDropdownWrapper> createState() => _InputDropdownWrapperState();
}

class _InputDropdownWrapperState extends State<InputDropdownWrapper> {
  @override
  Widget build(BuildContext context) {
    return RibnAppBarContainer(
      builder: (BuildContext context, RibnAppBarViewModel vm) => InputDropdown(
        selectedItem: vm.currentNetworkName,
        items: vm.networks,
        onChange: (string) {},
        chevronIconLink: RibnAssets.chevronDown,
        enabled: false,
      ),
    );
  }
}
