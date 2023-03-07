// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/select_action_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/create_new_wallet_password_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_wallet_page.dart';
import 'package:ribn/presentation/onboarding/widgets/opt_in_tracker_page.dart';
import 'package:ribn/providers/packages/entropy_provider.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';
import '../essential_test_provider_widget.dart';
import '../mocks/flutter_secure_storage_mocks.dart';
import '../mocks/store_mocks.dart';
import '../utils/onboarding_utils.dart';

void main() {
  testWidgets('Test Successful Import Wallet Flow', (WidgetTester tester) async {
    // TODO: Refactor styling so we don't have to override window size
    tester.binding.window.physicalSizeTestValue = Size(10000, 10000);

    final _mockStore = getStoreMocks(isNewUser: true);
    await tester.pumpWidget(
      await essentialTestProviderWidget(
        overrides: [
          entropyFuncProvider.overrideWith((ref) {
            return (_) => OnboardingState.test().mnemonic;
          }),
          flutterSecureStorageProvider.overrideWith((ref) {
            return () => getMockFlutterSecureStorage();
          }),
        ],
        mockStore: _mockStore,
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
    await tester.tap(find.byKey(SelectActionPage.importWalletActionButtonKey));
    await tester.pumpAndSettle();

    /// Wallet Restore
    await fillOutRestoreWalletMnemonic(tester: tester);
    await tester.tap(find.byKey(RestoreWalletPage.restoreWalletConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Create password
    expect(find.byKey(NewWalletPasswordPage.newWalletPasswordPageKey), findsOneWidget);
    await fillOutCreatePassword(tester: tester);
    await clickCreatePasswordConfirm(
      tester: tester,
      buttonKey: NewWalletPasswordPage.newWalletPasswordConfirmationButtonKey,
    );

    /// Make it to wallet balance screen
    expect(find.byKey(HomePage.homePageKey), findsOneWidget);
  });
}
