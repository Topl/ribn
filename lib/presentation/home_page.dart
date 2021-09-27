// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/home_container.dart';
import 'package:ribn/presentation/address_section.dart';
import 'package:flutter/services.dart';
import 'package:mubrambl/src/core/amount.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: Rules.numHomeTabs, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              _buildNetworkMenu(vm.currentNetwork, vm.networks, vm.updateNetwork),
              _buildSettingsMenu()
            ],
          ),
          body: Column(
            children: [
              _buildDisplayAddress(vm.displayAddress),
              Padding(
                padding: const EdgeInsets.all(UIConstants.generalPadding),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      vm.fetchingBalance
                          ? const CircularProgressIndicator()
                          : Text(
                              '${vm.totalBalance} Polys',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                      MaterialButton(
                        child: const Icon(Icons.refresh),
                        onPressed: vm.refreshBalance,
                      )
                    ],
                  ),
                ),
              ),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    _buildAssetsList(vm.fetchingBalance, vm.assets),
                    const SizedBox(),
                    AddressSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: _onSelected,
      itemBuilder: (BuildContext context) {
        return Rules.settings.map(
          (String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          },
        ).toList();
      },
    );
  }

  Widget _buildNetworkMenu(String dropdownValue, List<String> networks, Function(String) onChange) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? networkId) => onChange(networkId!),
      items: networks.map<DropdownMenuItem<String>>((String networkId) {
        return DropdownMenuItem<String>(
          value: networkId,
          child: Text(Rules.networkStrings[int.parse(networkId)] ?? ""),
        );
      }).toList(),
    );
  }

  Widget _buildDisplayAddress(String displayAddr) {
    return Padding(
      padding: const EdgeInsets.all(UIConstants.generalPadding),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: UIConstants.displayAddressWidth(context)),
          child: MaterialButton(
            onPressed: () => Clipboard.setData(ClipboardData(text: displayAddr)),
            child: Tooltip(
              message: Strings.copyToClipboard,
              child: Text(
                displayAddr,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: UIConstants.smallTextSize,
                  overflow: TextOverflow.ellipsis,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      automaticIndicatorColorAdjustment: true,
      tabs: const [
        Tab(child: Text(Strings.assets)),
        Tab(child: Text(Strings.send)),
        Tab(child: Text(Strings.receive)),
      ],
    );
  }

  void _onSelected(String choice) {
    switch (choice) {
      case Strings.logout:
        {
          Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(Routes.login, (route) => false);
          break;
        }
      default:
        break;
    }
  }

  Widget _buildAssetsList(bool fetchingBalance, List<AssetAmount> assets) {
    return fetchingBalance
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : assets.isEmpty
            ? const Text("You have no assets :(")
            : ListView.builder(
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: UIConstants.generalPadding,
                    ),
                    child: Text(
                      "${assets[index].assetCode.shortName.show} - ${assets[index].assetCode.serialize()}: ${assets[index].quantity}",
                    ),
                  );
                },
              );
  }
}
