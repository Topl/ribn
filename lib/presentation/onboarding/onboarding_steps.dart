import 'package:flutter/material.dart';
import 'package:ribn/presentation/onboarding/create_password_page.dart';
import 'package:ribn/presentation/onboarding/read_carefully_page_two.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_display_page.dart';
import 'package:ribn/presentation/onboarding/seed_phrase_generating_page.dart';
import 'package:ribn/presentation/onboarding/wallet_created_page.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/colors.dart';

/// Builds PageViews for generating and confirming the seed phrase, and creating a wallet password.
class OnboardingStepsPage extends StatefulWidget {
  const OnboardingStepsPage({Key? key}) : super(key: key);

  @override
  OnboardingStepsPageState createState() => OnboardingStepsPageState();
}

class OnboardingStepsPageState extends State<OnboardingStepsPage> {
  final Duration pageTransitionDuration = Duration.zero;
  int currPage = 0;

  /// Indicates the text to display in [SeedPhraseDisplayPage]
  bool backButtonPressed = false;

  void onBackPressed() {
    if (currPage > 0) {
      setState(() {
        backButtonPressed = true;
      });
    }
    goToPrevPage();
  }

  @override
  Widget build(BuildContext context) {
    // back button only shows up after the 1st page
    final bool showBackButton = currPage > 1;
    return Scaffold(
      backgroundColor: RibnColors.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingAppBar(
              onBackPressed: showBackButton ? onBackPressed : null,
              currPage: currPage,
            ),
            Flexible(child: buildPage()),
          ],
        ),
      ),
    );
  }

  /// Builds the appropriate page based on the [currPage]
  Widget buildPage() {
    switch (currPage) {
      case 0:
        return SeedPhraseGeneratingPage(goToNextPage);
      case 1:
        return SeedPhraseDisplayPage(goToNextPage, backButtonPressed);
      case 2:
        return SeedPhraseConfirmationPage(goToNextPage);
      case 3:
        return CreatePasswordPage(goToNextPage);
      case 4:
        return ReadCarefullyPageTwo(goToNextPage);
      case 5:
        return const WalletCreatedPage();
      default:
        return const SizedBox();
    }
  }

  /// Updates the [currPage] to the next page
  void goToNextPage() {
    setState(() {
      currPage = currPage + 1;
    });
  }

  /// Updates the [currPage] to the previous page
  void goToPrevPage() {
    setState(() {
      currPage = currPage - 1;
    });
  }
}
