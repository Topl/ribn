// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_wallet_page.dart';
import 'package:ribn/presentation/onboarding/widgets/password_section.dart';
import '../constants/onboarding_constants.dart';
import '../essential_test_provider_widget.dart';

/// This will fill out the seed phase confirmation text fields
///
/// Can pass in [mobileConfirmIdxs]
/// Can pass in [mnemonic]. If you want to check negative cases,
/// you may pass in a mnemonic that does not match the users initial sign uo mnemonic
Future<void> fillOutSeedPhraseConfirmation({
  required WidgetTester tester,
  List<int>? mobileConfirmIdxs,
  List<String>? mnemonic,
}) async {
  if (mobileConfirmIdxs == null) {
    mobileConfirmIdxs = OnboardingState.test().mobileConfirmIdxs;
  }

  if (mnemonic == null) {
    mnemonic = OnboardingState.test().shuffledMnemonic;
  }
  expect(find.byKey(SeedPhraseConfirmationPage.seedPhraseConfirmationPageKey), findsOneWidget);

  for (var i = 0; i < mobileConfirmIdxs.length; i++) {
    final textFieldKey = find.byKey(SeedPhraseConfirmationPage.confirmationTextFieldKey(i));

    final int index = mobileConfirmIdxs[i];

    await tester.enterText(textFieldKey, mnemonic[index]);
    await tester.pumpAndSettle();
  }
}

Future<void> fillOutCreatePassword({
  required WidgetTester tester,
  String password = testPassword,
  String? confirmPassword,
}) async {
  if (confirmPassword == null) confirmPassword = password;

  expect(find.byKey(PasswordSection.passwordSectionKey), findsOneWidget);

  await tester.enterText(find.byKey(PasswordSection.newPasswordTextFieldKey), testPassword);
  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(PasswordSection.confirmPasswordTextFieldKey), confirmPassword);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(PasswordSection.termsOfAgreementCheckboxKey));
  await tester.pumpAndSettle();
}

Future<void> clickCreatePasswordConfirm({
  required WidgetTester tester,
  required Key buttonKey,
}) async {
  await customRunAsync(tester, test: () async {
    await tester.tap(find.byKey(buttonKey));
    await Future.delayed(Duration(milliseconds: 200));
    await pumpTester(tester, duration: 10, loops: 1000);
    await Future.delayed(Duration(milliseconds: 200));
  });
}

Future<void> fillOutRestoreWalletMnemonic({
  required WidgetTester tester,
  String? mnemonic,
}) async {
  if (mnemonic == null) {
    mnemonic = OnboardingState.test().mnemonic;
  }
  expect(find.byKey(RestoreWalletPage.restoreWalletPageKey), findsOneWidget);

  await tester.enterText(find.byKey(RestoreWalletPage.mnemonicTextFieldKey), mnemonic);
  await tester.pumpAndSettle();
}
