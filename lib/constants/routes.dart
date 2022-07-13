import 'package:flutter/material.dart';

class Routes {
  const Routes._();

  /// A [RouteObserver] that can be attached to widgets to allow listening for route changes.
  static RouteObserver routeObserver = RouteObserver();

  /// Routes used throughout the application.
  static const welcome = '/welcome';
  static const selectAction = '/select-action';
  static const gettingStarted = '/getting-started';
  static const seedPhraseInfoChecklist = '/seedphrase-checklist';
  static const createPassword = '/create-password';
  static const onboardingSteps = '/onboarding-steps';
  static const seedPhraseInstructions = '/seed-phrase-instructions';
  static const generateSeedPhrase = '/generate-seed-phrase';
  static const displaySeedphrase = '/display-seed-phrase';
  static const walletInfoChecklist = '/wallet-info-checklist';

  static const seedPhraseConfirm = '/seed-phrase-confirm';
  static const extensionInfo = '/extension-info';
  static const login = '/login';
  static const loginRestoreWalletWithMnemonic = '/login/restore-wallet/mnemonic';
  static const loginRestoreWalletWithToplKey = '/login/restore-wallet/topl-key';
  static const loginRestoreWalletnewPassword = '/login/restore-wallet/new-password';
  static const loginRestoreWalletEnterPassword = '/login/restore-wallet/enter-password';
  static const onboardingRestoreWalletWithMnemonic = '/onboarding/restore-wallet/mnemonic';
  static const onboardingRestoreWalletWithToplKey = '/onboarding/restore-wallet/topl-key';
  static const onboardingRestoreWalletEnterPassword = '/onboarding/restore-wallet/enter-password';
  static const assetsTransferInput = '/asset-transfer';
  static const polyTransferInput = '/poly-transfer-input';
  static const txReview = '/tx-review';
  static const txConfirmation = '/tx-confirmation';
  static const mintInput = '/mint-input';
  static const settings = '/settings';
  static const assetDetails = '/asset-details';
  static const home = '/home';
  static const addresses = '/addresses';
  static const externalSigning = '/ext-signing';
  static const enable = '/enable';
  static const error = '/error';
}
