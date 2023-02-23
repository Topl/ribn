// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/keys.dart';

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
  /// The list of networks in the wallet.
  final List<String> networks;

  /// The name of the current network being viewed.
  final String currentNetworkName;

  /// Callback for updating/toggling the current network.
  final void Function(String) updateNetwork;

  /// Callback for when an item is selected from the settings drop down menu.
  final void Function(String) selectSettingsOption;

  /// Items in the settings drop down menu.
  final Map<String, Image> settingsOptions = {
    Strings.support: Image.asset(RibnAssets.supportIcon),
    Strings.settings: Image.asset(RibnAssets.settingsIcon),
  };

  RibnAppBarViewModel({
    required this.networks,
    required this.updateNetwork,
    required this.currentNetworkName,
    required this.selectSettingsOption,
  });
  static RibnAppBarViewModel fromStore(Store<AppState> store) {
    return RibnAppBarViewModel(
      networks: store.state.keychainState.allNetworks
          .map((e) => e.networkName)
          .toList(),
      currentNetworkName: store.state.keychainState.currentNetworkName,
      updateNetwork: (String network) {
        store.dispatch(UpdateCurrentNetworkAction(network));
      },
      selectSettingsOption: (String selectedOption) async {
        switch (selectedOption) {
          case Strings.settings:
            {
              store.dispatch(NavigateToRoute(Routes.settings));
              break;
            }
          case Strings.support:
            {
              if (kIsWeb) {
                await launchUrl(
                    Uri.parse("https://forms.gle/jtNTtD7kxGoo1ePJA"));
              } else {
                Keys.navigatorKey.currentState?.pushNamed(Routes.feedback);
              }

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
        other.currentNetworkName == currentNetworkName &&
        other.updateNetwork == updateNetwork &&
        other.selectSettingsOption == selectSettingsOption;
  }

  @override
  int get hashCode {
    return networks.hashCode ^
        currentNetworkName.hashCode ^
        updateNetwork.hashCode ^
        selectSettingsOption.hashCode;
  }
}
