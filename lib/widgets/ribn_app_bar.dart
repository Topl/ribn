import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/containers/ribn_app_bar_container.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/input_dropdown.dart';

/// Builds the top AppBar in the extension view.
/// Displays the network drop down and settings drop down.
class RibnAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RibnAppBar({Key? key})
      : preferredSize = const Size.fromHeight(40),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _RibnAppBarState createState() => _RibnAppBarState();
}

class _RibnAppBarState extends State<RibnAppBar> {
  @override
  Widget build(BuildContext context) {
    return RibnAppBarContainer(
      builder: (BuildContext context, RibnAppBarViewModel vm) => AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[RibnColors.tertiary, RibnColors.primaryOffColor],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 3,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputDropdown(
                selectedNetwork: vm.currentNetworkName,
                networks: vm.networks,
                onChange: vm.updateNetwork,
                chevronIconLink: RibnAssets.chevronDown,
              ),
              const Spacer(),
              _buildSettingsMenu(vm.settingsOptions, vm.selectSettingsOption),
            ],
          ),
        ),
        centerTitle: false,
      ),
    );
  }

  /// Builds the settings drop down menu.
  Widget _buildSettingsMenu(Map<String, SvgPicture> settingsOptions, Function(String)? onSelected) {
    return Container(
      color: RibnColors.primary,
      child: PopupMenuButton<String>(
        child: SizedBox(width: 30, child: SvgPicture.asset(RibnAssets.menuIcon)),
        offset: const Offset(0, 30),
        onSelected: onSelected,
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        itemBuilder: (BuildContext context) {
          return settingsOptions.keys.map(
            (String currOption) {
              return PopupMenuItem<String>(
                value: currOption,
                padding: EdgeInsets.zero,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 15, child: settingsOptions[currOption]),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child: Text(
                          currOption,
                          style: const TextStyle(
                            color: RibnColors.primary,
                            fontSize: 12,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }
}
