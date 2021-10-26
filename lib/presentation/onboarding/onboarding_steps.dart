import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/presentation/onboarding/create_password_page.dart';
import 'package:ribn/presentation/onboarding/read_carefully_page_two.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_display_page.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_generating_page.dart';
import 'package:ribn/presentation/onboarding/wallet_created_page.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

class OnboardingStepsPage extends StatefulWidget {
  const OnboardingStepsPage({Key? key}) : super(key: key);

  @override
  OnboardingStepsPageState createState() => OnboardingStepsPageState();
}

class OnboardingStepsPageState extends State<OnboardingStepsPage> {
  final PageController controller = PageController();
  final Duration pageTransitionDuration = const Duration(milliseconds: 200);
  int currPage = 0;
  bool backButtonPressed = false;

  ///
  void onBackPressed() {
    if (currPage > 0) {
      setState(() {
        backButtonPressed = true;
      });
      goToPrevPage();
    } else {
      Keys.navigatorKey.currentState!.pop();
    }
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currPage = controller.page?.floor() ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardingAppBar(
        onBackPressed: currPage > 1 ? onBackPressed : null,
        currPage: currPage,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          SeedPhraseGeneratingPage(goToNextPage),
          SeedPhraseDisplayPage(goToNextPage, backButtonPressed),
          SeedPhraseConfirmationPage(goToNextPage),
          CreatePasswordPage(goToNextPage),
          ReadCarefullyPageTwo(goToNextPage),
          const WalletCreatedPage(),
        ],
      ),
    );
  }

  void goToNextPage() {
    controller.nextPage(duration: pageTransitionDuration, curve: Curves.bounceIn);
  }

  void goToPrevPage() {
    controller.previousPage(duration: pageTransitionDuration, curve: Curves.bounceOut);
  }
}
