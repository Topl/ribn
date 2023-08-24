import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/receive_assets/widgets/receive_assets_address_screen.dart';
import 'package:ribn/v2/receive_assets/widgets/select_asset.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';

class ReceiveAssets extends ScreenConsumerWidget {
  static const receiveAssetsKey = Key('receiveAssetsKey');

  ReceiveAssets({
    Key? key,
  }) : super(key: key, route: '/receive');

  final _pages = [
    SelectAssetsScreen(),
    ReceiveAssetsAddressScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StepperScreen(
      pages: _pages,
      onDone: () {
        print('done');
      },
    );
  }
}
