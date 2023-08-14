import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../v1/constants/strings.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/ribn_text_style.dart';
import '../../shared/widgets/step_indicator.dart';
import '../providers/stepper_screen_provider.dart';

class StepperScreen extends HookConsumerWidget {
  StepperScreen({
    Key? key,
    required this.pages,
  }) : super(key: key);

  final List<Widget> pages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageCount = pages.length;

    final notifier = ref.watch(stepperScreenProvider.notifier);
    final receiveAssets = ref.watch(stepperScreenProvider);
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
                  child: Text(
                    Strings.done,
                    style: RibnTextStyle.h3.copyWith(color: RibnColors.secondary),
                  ),
                ),
              ),
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
          children: pages,
        ),
      ),
    );
  }
}
