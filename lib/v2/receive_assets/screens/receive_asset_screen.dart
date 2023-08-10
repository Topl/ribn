import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/receive_assets/providers/receive_assets_provider.dart';

import '../../../v1/constants/strings.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/ribn_text_style.dart';
import '../../shared/extensions/screen_hook_widget.dart';
import '../../shared/widgets/step_indicator.dart';
import '../widgets/receive_assets_address_screen.dart';
import '../widgets/select_asset.dart';

class ReceiveAssets extends ScreenConsumerWidget {
  static const welcomePageKey = Key('receiveAssetsKey');

  ReceiveAssets({
    Key? key,
  }) : super(key: key, route: '/receive');

  static const _pageCount = 2;

  final _pages = [
    SelectAssetsScreen(),
    ReceiveAssetsAddressScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(receiveAssetsProvider.notifier);
    final receiveAssets = ref.watch(receiveAssetsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            notifier.navigateToPage(reverse: true);
          },
        ),
        actions: [
          // Only show finalize  button when on last page
          if (receiveAssets.pageIndex == _pageCount - 1)
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
            currentStep: receiveAssets.pageIndex,
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
