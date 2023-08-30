/// All the strings that are being used throughout the app.
class Strings {
  Strings._();

  // Onboarding
  static const String welcomeToRibn = 'Welcome To Ribn';
  static const String welcomeToRibnSubheader = 'Topl’s blockchain wallet used to track, tokenize, and transact impact.';
  static const String createWallet = 'Create wallet';
  static const String importWallet = 'Import wallet';
  static const String helpUsImprove = 'Help us improve Ribn';
  static const String dataDisclaimerHeader =
      'Ribn Wallet would like to gather usage data to better understand user interactions. This data will be used to continually improve user experience and Topl\'s ecosystem.';
  static const String dataDisclaimerListHead = 'You can always opt-out at anytime via Settings. ';
  static const String dataDisclaimerList1 =
      'Never collect keys, addresses, transactions,\n   balances, hashes, or any personal information.';
  static const String dataDisclaimerList2 = 'Never collect your full IP address.';
  static const String dataDisclaimerList3 = 'Never sell data for profit.';
  static const String dataDisclaimerFooter =
      'This data is aggregated and is therefore anonymous for the purposes of General Data Protection Regulation (EU) 2016/679. For more information in relation to our privacy practices, please see our ';
  static const String dataDisclaimerFooterPrivacyPolicyText = "Privacy policy here.";
  static const String noThanks = "No, thanks";
  static const String iAgree = "I agree";
  static const String done = "Done";
  static const String next = "Next";

  // Create Pin Flow
  static const String createPin = 'Create a PIN';
  static const String createPinDisclaimer =
      'Please, don’t use the same numbers in a row. \nDon’t show your PIN to anyone.';
  static const String confirmPin = 'Type your PIN again';
  static const String confirmPinDisclaimer = 'Confirm the PIN code repeating the combination of numbers.';

  // Pin field
  static const String pinNotLongEnough = 'PIN must be at least 6 characters long.';
  static const String incorrectPin = 'Incorrect PIN. Please check and try again.';
  static const String unsafePin = 'Not a safe pin, Please try again.';

  // Biometrics
  static const String enableFingerprint = 'Enable Fingerprint';
  static const String enableFingerprintDisclaimer =
      'Login to your wallet with your fingerprint. \nFast, simple and safe.';
  static const String skipNow = 'Skip now';

  // Ready Recovery Phrase
  static const String readyRecoveryPhrase = 'Ready to record the recovery phrase?';
  static const String readyRecoveryPhraseHead =
      'This phrase will help restore access to your wallet. Even if you lose your phone or delete an app.';
  static const String readyRecoveryPhraseListHead =
      'Please prepare at least one of the following to record your seed phrase safely.';
  static const String readyRecoveryPhraseList1 = 'A paper and pen.';
  static const String readyRecoveryPhraseList2 = 'A secure password manager.';
  static const String readyRecoveryPhraseList3 = 'A program such as PGP to encrypt your text\n   file.';

  // Recovery Phrase  before you start
  static const String beforeYouStart = 'Before you start';
  static const String beforeYouStartDisclaimer =
      'We are about to show you 12 words to write down and keep in a safe place. Write down the each word in the exact order it is presented.';
  static const String beforeYouStartListHead =
      'Please keep your recovery phrase in a safe place. If you show it to anyone, you may lose access to your funds.';
  static const String beforeYouStartList1 = 'Do not share this phrase with anyone\n (not even Ribn tech support).';
  static const String beforeYouStartList2 = 'We cannot help you regain access if you\n lose your passphrase.';
  static const String imReady = 'I\'m ready';

  // Recovery Phrase
  static const String recoveryPhrase = 'This is your recovery phrase';
  static const String recoveryPhraseSub =
      'Write all these words down on a piece of paper or secure program, and keep in a safe place.';
  static const String setRecoveryPhrase = 'Set recovery phrase';
  static const String copy = 'Copy';

  // Recovery Phrase check
  static const String letsCheckIt = 'Let’s check it';
  static const String letsCheckItSub = 'Please make sure your recovery phrase is written down correctly.';
  static const String letsCheckItError = 'One of the selected words is incorrect';
  static const String selectWordNum = 'Select word #';

  // Onboarding Finish
  static const String onboardingFinish = 'Congrats on creating your Ribn wallet!';
  static const String onboardingFinishSub =
      'You can now securely store, manage, and interact with your digital assets and DApps in the Topl ecosystem.';
  static const String onboardingFinishDisclaimer = 'Keep your wallet secure to protect your assets.';
  static const String goToWallet = 'Go to wallet';

  // Semantic Labels for Accessibility
  static const String semanticFingerprint = 'Fingerprint';
  static const String semanticCopy = 'Copy';
  static const String sendAssets = 'Send assets';
  static const String receive = 'Receive';
  static const String close = 'Close';
  static const String receiveAssets = 'Receive assets';
  static const String totalBalance = 'Total Balance';
  static const String assetHeader = 'Asset Header';
  static const String chooseAnAsset = 'Choose an asset';
  static const String createRibnWallet = "Congrats on creating your Ribn wallet!";
  static const String createRibnWalletSub =
      "You can now securely store, manage, and interact with your digital assets and DApps in the Topl ecosystem.";
  static const String keepWalletSecure = "Keep your wallet secure to protect your assets.";

  static const String send = 'Send';
  static const String sendAddress = 'Enter the recipient address or scan QR code';
  static const String sendTransferAmount = 'Enter the transfer amount';
  static const String checkSummary = 'Check the summary';
  static const String enterAddress = 'Enter address';
  static const String enterAddressNotification =
      'Please make sure the address matches the one provided by the recipient.';
  static const String search = 'Search';
  static const String setRecoveryPhraseButton = 'Next';

  // Activity
  static const String activity = 'Activity';
  static const String activityReceived = 'Received';
  static const String activitySent = 'Sent';
  static const String activityFees = 'Fees';
  static const String currencyLVL = 'LVL';
  static const String currencyUSD = 'USD';
  static const String currencyETH = 'ETH';
}
