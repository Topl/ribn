// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/widgets/asset_list/asset_list.dart';
import 'package:ribn/v2/asset_managment/widgets/asset_screen_header/asset_screen_header.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/asset_managment/providers/loaded_assets_provider.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';

class AssetManagementScreen extends ScreenConsumerWidget {
  static const Key assetManagementScreenKey = Key('assetManagementScreenKey');
  const AssetManagementScreen({
    Key key = assetManagementScreenKey,
  }) : super(key: key, route: '/asset_management');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO SDK: Move up to a higher level widget
    ref.watch(loadedAssetsProvider);

    return Scaffold(
      backgroundColor: RibnColors.grey,
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: AssetScreenHeader(),
                ),
                Expanded(
                  flex: 3,
                  child: AssetList(),
                ),
              ],
            )),
      ),
    );
  }
}
