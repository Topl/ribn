import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/constants/assets.dart';
import 'package:ribn/v2/constants/colors.dart';
import 'package:ribn/v2/constants/ribn_text_style.dart';
import 'package:ribn/v2/constants/strings.dart';
import 'package:ribn/v2/presentation/onboarding/onboarding_modal.dart';
import 'package:ribn/v2/presentation/widgets/ribn_button.dart';

class WelcomePage extends HookConsumerWidget {
  static const welcomePageKey = Key('welcomePageKey');
  static const welcomePageCreateButtonKey = Key('welcomePageCreateButtonKey');
  static const welcomePageImportButtonKey = Key('welcomePageImportButtonKey');

  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(Assets.ribnLogoIcon, height: 120),
            Spacer(),
            Text(Strings.welcomeToRibn,
                textAlign: TextAlign.left,
                style: RibnTextStyle.h1.copyWith(
                    // color: RibnColors.lightGreyTitle,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 20),
            Text(
              Strings.welcomeToRibnSubheader,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h3.copyWith(
                color: RibnColors.greyText,
              ),
            ),
            SizedBox(height: 30),
            RibnButton(
              key: welcomePageCreateButtonKey,
              text: Strings.createWallet,
              onPressed: () {
                showOnboardingModal(context);
                // Keys.navigatorKey.currentState?.pushNamed(Routes.optIn);
              },
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    key: welcomePageImportButtonKey,
                    onPressed: () => {},
                    child: Text("Import Wallet",
                        style: RibnTextStyle.buttonLarge.copyWith(
                          color: RibnColors.defaultText,
                          fontWeight: FontWeight.w500,
                        )))),
          ],
        ),
      ),
    );
  }
}

void showOnboardingModal(BuildContext context) {
  final DraggableScrollableController scrollController = DraggableScrollableController();
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
          initialChildSize: 0.9,
          // near full modal on load
          maxChildSize: 1,
          // full screen on scroll
          minChildSize: 0.25,
          expand: false,
          controller: scrollController,
          builder: (BuildContext context, ScrollController scrollController) {
            return OnboardingModal();
          });
    },
  );
}
