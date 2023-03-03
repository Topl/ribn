import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/create_password_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/getting_started_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_display_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_generating_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_instructions_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/select_action_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_created_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/onboarding/widgets/opt_in_tracker_page.dart';
import 'package:ribn/providers/packages/entropy_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';

import '../essential_test_provider_widget.dart';
import '../mocks/flutter_secure_storage_mocks.dart';
import '../mocks/store_mocks.dart';
import '../utils/onboarding_utils.dart';

void main() {
  testWidgets('Test Successful Create Wallet Flow', (WidgetTester tester) async {
    // TODO: Refactor styling so we don't have to override window size
    tester.binding.window.physicalSizeTestValue = Size(10000, 10000);
    await tester.pumpWidget(
      await essentialTestProviderWidget(
        overrides: [
          entropyFuncProvider.overrideWith((ref) => (_) => OnboardingState.test().mnemonic),
          flutterSecureStorageProvider.overrideWith((ref) {
            return () => getMockFlutterSecureStorage();
          }),
        ],
        mockStore: getStoreMocks(isNewUser: true),
      ),
    );

    /// Welcome Page Section
    expect(find.byKey(WelcomePage.welcomePageKey), findsOneWidget);
    await tester.tap(find.byKey(WelcomePage.welcomePageConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Opt In
    expect(find.byKey(OptInTracker.optInTrackerKey), findsOneWidget);
    await tester.tap(find.byKey(OptInTracker.noThanksKey));
    await tester.pumpAndSettle();

    /// Select Action
    expect(find.byKey(SelectActionPage.selectActionPageKey), findsOneWidget);
    await tester.tap(find.byKey(SelectActionPage.createWalletActionButtonKey));
    await tester.pumpAndSettle();

    /// Getting Started
    expect(find.byKey(GettingStartedPage.gettingStartedPageKey), findsOneWidget);
    await tester.tap(find.byKey(GettingStartedPage.gettingStartedConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Seed phrase info checklist
    expect(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistPageKey), findsOneWidget);
    // Try to tap confirm button and make sure the page does not change
    await tester.tap(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistConfirmationButtonKey));
    await tester.pumpAndSettle();
    expect(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistPageKey), findsOneWidget);

    // Now try and tap the first checkbox and attempt to move pages, should stay on same page
    await tester.tap(find.byKey(SeedPhraseInfoChecklistPage.neverShareMySeedPhraseKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistConfirmationButtonKey));
    await tester.pumpAndSettle();
    expect(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistPageKey), findsOneWidget);

    // Now tap the second checkbox and page should move to next page
    await tester.tap(find.byKey(SeedPhraseInfoChecklistPage.walletRecoveryUsingSeedPhraseKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(SeedPhraseInfoChecklistPage.seedPhraseInfoChecklistConfirmationButtonKey));
    await tester.pumpAndSettle();
    expect(find.byKey(SeedPhraseInstructionsPage.seedPhraseInstructionsPageKey), findsOneWidget);
    await tester.tap(find.byKey(SeedPhraseInstructionsPage.seedPhraseInstructionsConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Seed phrase generation
    expect(find.byKey(SeedPhraseGeneratingPage.seedPhraseGeneratingPageKey), findsOneWidget);
    // The seed generation page has a set time delay and this will make time pass so that the confirm button will appear
    await pumpTester(tester, duration: 1, loops: 10);
    await tester.tap(find.byKey(SeedPhraseGeneratingPage.seedPhraseGeneratingConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Seed phrase Display
    expect(find.byKey(SeedPhraseDisplayPage.seedPhraseDisplayPageKey), findsOneWidget);
    await tester.tap(find.byKey(SeedPhraseDisplayPage.seedPhraseDisplayConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Seed phrase confirmation section
    expect(find.byKey(SeedPhraseConfirmationPage.seedPhraseConfirmationPageKey), findsOneWidget);
    await fillOutSeedPhraseConfirmation(tester: tester);
    await tester.tap(find.byKey(SeedPhraseConfirmationPage.seedPhraseConfirmationConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Create Password section
    expect(find.byKey(CreatePasswordPage.createPasswordPageKey), findsOneWidget);
    await fillOutCreatePassword(tester: tester);
    await tester.pumpAndSettle();
    await clickCreatePasswordConfirm(
      tester: tester,
      buttonKey: CreatePasswordPage.createPasswordConfirmationButtonKey,
    );

    /// Wallet Info Checklist  Section
    expect(find.byKey(WalletInfoChecklistPage.walletInfoChecklistPageKey), findsOneWidget);
    await tester.tap(find.byKey(WalletInfoChecklistPage.savedMyWalletPasswordSafelyKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(WalletInfoChecklistPage.toplCannotRecoverForMeKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(WalletInfoChecklistPage.spAndPasswordUnrecoverableKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(WalletInfoChecklistPage.walletInfoChecklistConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Wallet Page Created Section
    expect(find.byKey(WalletCreatedPage.walletCreatedPageKey), findsOneWidget);
    await tester.ensureVisible(find.byKey(WalletCreatedPage.walletCreatedConfirmationButtonKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(WalletCreatedPage.walletCreatedConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Make it to wallet balance screen
    expect(find.byKey(HomePage.homePageKey), findsOneWidget);

    await pendingTimersFix(tester);
  });
}
