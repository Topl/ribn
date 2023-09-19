import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vrouter/vrouter.dart';

import '../../../v1/constants/strings.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/ribn_text_style.dart';
import '../../shared/widgets/step_indicator.dart';
import '../providers/stepper_navigation_control_prover.dart';
import '../providers/stepper_screen_provider.dart';

class StepperScreen extends HookConsumerWidget {
  StepperScreen({
    Key? key,
    required this.pages,
    required this.onDone,
  }) : super(key: key);

  final List<Widget> pages;
  final Function onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageCount = pages.length;

    final notifier = ref.watch(stepperScreenProvider.notifier);
    final stepperScreen = ref.watch(stepperScreenProvider);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              if (stepperScreen.pageIndex <= 0) {
                context.vRouter.historyBack();
                return;
              }
              notifier.navigateToPage(context, reverse: true);
            },
          ),
          actions: [
            // Only show finalize  button when on last page
            if (stepperScreen.pageIndex == _pageCount - 1)
              DoneButton(onDone: onDone)
            else if (stepperScreen.pageIndex < _pageCount - 1)
              NextButton()
          ],
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.fromLTRB(40, 5, 80, 5),
            height: 20,
            child: StepIndicator(
              currentStep: stepperScreen.pageIndex,
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
      ),
      onWillPop: () async {
        return notifier.navigateToPage(context, reverse: true);
      },
    );
  }
}

class DoneButton extends HookConsumerWidget {
  const DoneButton({
    super.key,
    required this.onDone,
  });

  final Function onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDoneEnabled = ref.watch(stepperNavigationControlProvider).done;
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: InkWell(
        onTap: () {
          if (!isDoneEnabled) return;
          onDone();
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            Strings.done,
            style: RibnTextStyle.h3.copyWith(
              color: isDoneEnabled ? RibnColors.secondary : RibnColors.secondary.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}

class NextButton extends HookConsumerWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(stepperScreenProvider.notifier);
    final isNextEnabled = ref.watch(stepperNavigationControlProvider).next;
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: InkWell(
        onTap: () {
          if (!isNextEnabled) return;
          notifier.navigateToPage(context);
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            Strings.next,
            style: RibnTextStyle.h3.copyWith(
              color: isNextEnabled ? RibnColors.secondary : RibnColors.secondary.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
