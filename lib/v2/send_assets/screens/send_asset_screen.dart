import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/activity/screens/activity_screen.dart';
import 'package:ribn/v2/send_assets/widgets/select_asset.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_address.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_complete.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_summary.dart';
import 'package:ribn/v2/send_assets/widgets/send_transfer_amount.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/widgets/stepper_screen.dart';
import 'package:vrouter/vrouter.dart';

class SendAssetScreen extends ScreenConsumerWidget {
  static const welcomePageKey = Key('sendAssetKey');
  SendAssetScreen({
    Key? key,
  }) : super(key: key, route: '/send_asset');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StepperScreen(
        pages: [
          SelectAssetsScreen(),
          SendAssetsAddressScreen(),
          SendTransferAmountScreen(),
          SendAssetSummaryScreen(),
          SendAssetCompleteScreen()
        ],
        onDone: () async {
          context.vRouter.to(ActivityScreen().route);
        });
  }
}
