// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/core/extensions/widget_extensions.dart';
import 'package:ribn/v2/core/providers/onboarding_provider.dart';
import 'package:ribn/v2/view/onboarding/modals/biometrics_modal.dart';
import 'package:ribn/v2/view/onboarding/pages/confirm_pin_page.dart';
import 'package:ribn/v2/view/onboarding/pages/confirm_recovery_phrase_page.dart';
import 'package:ribn/v2/view/onboarding/pages/create_pin_page.dart';
import 'package:ribn/v2/view/onboarding/pages/ready_recovery_phrase_page.dart';
import 'package:ribn/v2/view/onboarding/pages/recovery_phrase_page.dart';
import 'package:ribn/v2/view/widgets/step_indicator.dart';

class OnboardingFlowPage extends HookConsumerWidget {
  OnboardingFlowPage({
    Key? key,
  }) : super(key: key);

  static const _pageCount = 5;

  final _pages = [
    CreatePinPage(),
    ConfirmPinPage(),
    RecoveryPhraseInstructionsPage(),
    RecoveryPhrasePage(),
    ConfirmRecoveryPhrasePage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);
    final notifier = ref.watch(onboardingProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        return notifier.navigate(context, reverse: true);
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                notifier.navigate(context, reverse: true);
              },
            ),
            actions: [
              // Only show finalize  button when on last page
              if (onboarding.pageIndex == _pageCount - 1)
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
                currentStep: onboarding.pageIndex,
                totalSteps: 5,
                currentIndicatorColor: RibnColors.primary,
                indicatorColor: RibnColors.grey,
              ),
            )),
        body: Center(
            child: PageView(
          controller: notifier.pageController,
          physics: const NeverScrollableScrollPhysics(), // Disable swiping
          children: _pages,
        )),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   BiometricsModal().showAsModal(context);
        // }),
      ),
    );
  }
}
