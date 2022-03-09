import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redux/redux.dart';

import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';

class RibnAppBarContainer extends StatelessWidget {
  const RibnAppBarContainer({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final ViewModelBuilder<RibnAppBarViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAppBarViewModel>(
      distinct: true,
      converter: RibnAppBarViewModel.fromStore,
      builder: builder,
    );
  }
}

class RibnAppBarViewModel {
  final List<int> networks;
  final int currentNetwork;
  final void Function(String) updateNetwork;
  final void Function(String) selectSettingsOption;
  final Map<String, SvgPicture> settingsOptions = {
    Strings.support: SvgPicture.asset(RibnAssets.supportIcon),
    Strings.settings: SvgPicture.asset(RibnAssets.settingsIcon),
  };

  RibnAppBarViewModel({
    required this.networks,
    required this.updateNetwork,
    required this.currentNetwork,
    required this.selectSettingsOption,
  });
  static RibnAppBarViewModel fromStore(Store<AppState> store) {
    return RibnAppBarViewModel(
      networks: store.state.keychainState.networks.map((e) => e.networkId).toList(),
      currentNetwork: store.state.keychainState.currentNetwork.networkId,
      updateNetwork: (String networkId) {
        store.dispatch(UpdateCurrentNetworkAction(networkId));
      },
      selectSettingsOption: (String selectedOption) {
        switch (selectedOption) {
          case Strings.settings:
            {
              store.dispatch(NavigateToRoute(Routes.settings));
              break;
            }
          default:
            break;
        }
      },
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RibnAppBarViewModel &&
        listEquals(other.networks, networks) &&
        other.currentNetwork == currentNetwork &&
        other.updateNetwork == updateNetwork &&
        other.selectSettingsOption == selectSettingsOption;
  }

  @override
  int get hashCode {
    return networks.hashCode ^ currentNetwork.hashCode ^ updateNetwork.hashCode ^ selectSettingsOption.hashCode;
  }
}
