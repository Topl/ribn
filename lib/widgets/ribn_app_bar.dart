import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/ribn_app_bar_container.dart';
import 'package:ribn/utils.dart';

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
        backgroundColor: RibnColors.primary,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNetworkMenu(vm.currentNetworkName, vm.networks, vm.updateNetwork),
              const Spacer(),
              _buildSettingsMenu(vm.settingsOptions, vm.selectSettingsOption),
            ],
          ),
        ),
        centerTitle: false,
      ),
    );
  }

  /// Builds the network drop down menu.
  Widget _buildNetworkMenu(
    String selectedNetwork,
    List<String> networks,
    Function(String) onChange,
  ) {
    return Container(
      width: 90,
      height: 25,
      decoration: BoxDecoration(
        color: const Color(0xFF25B0A3),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(5),
      child: PopupMenuButton<String>(
          offset: const Offset(0, 25),
          padding: const EdgeInsets.all(0.0),
          elevation: 0,
          itemBuilder: (context) {
            return networks.map(
              (String networkName) {
                return PopupMenuItem(
                  value: networkName,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          backgroundColor:
                              networkName == selectedNetwork ? const Color(0xFF80FF00) : const Color(0xffbdbdbd),
                          radius: 3,
                        ),
                      ),
                      Text(capitalize(networkName)),
                    ],
                  ),
                );
              },
            ).toList();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(backgroundColor: Color(0xFF80FF00), radius: 3),
              ),
              SizedBox(
                height: 15,
                width: 50,
                child: Text(
                  capitalize(selectedNetwork),
                  style: RibnTextStyles.h3.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white, size: 10),
            ],
          ),
          onSelected: (String network) {
            onChange(network);
          }),
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
                            fontFamily: 'Poppins',
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
