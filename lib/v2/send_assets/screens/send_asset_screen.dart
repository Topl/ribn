import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/send_asset_provider.dart';
import 'package:ribn/v2/send_assets/widgets/select_asset.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_address.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_complete.dart';
import 'package:ribn/v2/send_assets/widgets/send_asset_summary.dart';
import 'package:ribn/v2/send_assets/widgets/send_transfer_amount.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';

import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/widgets/step_indicator.dart';

class SendAssetScreen extends ScreenConsumerWidget {
  static const welcomePageKey = Key('sendAssetKey');
  SendAssetScreen({
    Key? key,
  }) : super(key: key, route: '/send_asset');

  static const _pageCount = 5;

  final _pages = [
    SelectAssetsScreen(),
    SendAssetsAddressScreen(),
    SendTransferAmountScreen(),
    SendAssetSummaryScreen(),
    SendAssetCompleteScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(sendAssetProvider.notifier);
    final sendAsset = ref.watch(sendAssetProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            notifier.navigateToPage(context);
            //notifier.navigate(context);
          },
        ),
        actions: [
          // Only show finalize  button when on last page
          if (sendAsset.pageIndex == _pageCount - 1)
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    notifier.finish();
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(Strings.done, style: RibnTextStyle.h3.copyWith(color: RibnColors.secondary)))),
            ),
        ],
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.fromLTRB(40, 5, 80, 5),
          height: 20,
          child: StepIndicator(
            currentStep: sendAsset.pageIndex,
            totalSteps: _pageCount,
            currentIndicatorColor: RibnColors.primary,
            indicatorColor: RibnColors.grey,
          ),
        ),
      ),
      body: Center(
        child: PageView(
          controller: notifier.pageController,
          physics: const NeverScrollableScrollPhysics(), // Disable swiping
          children: _pages,
        ),
      ),
    );
  }
}
