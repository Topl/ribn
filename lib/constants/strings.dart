/// All the strings that are being used throughout the app.
class Strings {
  Strings._();
  static const String copyToClipboard = 'Copy to clipboard';
  static const String activity = 'Activity';
  static const String assets = 'Assets';
  static const String send = 'Send';
  static const String receive = 'Receive';
  static const String transactionHistory = 'Transaction History';
  static const String generateNewAddress = 'GENERATE NEW ADDRESS';
  static const String noAddresses = 'You have no addresses';
  static const String settings = 'Settings';
  static const String support = 'Support';
  static const String valhalla = 'valhalla';
  static const String toplnet = 'toplnet';
  static const String private = 'private';
  static const String receiver = 'Receiver';
  static const String amount = 'Amount';
  static const String polyTransfer = 'Poly Transfer';
  static const String assetTransfer = 'Asset Transfer';
  static const String minting = 'Minting';
  static const String totalAmount = 'Total Amount';
  static const String assetName = 'Asset name';
  static const String assetLongName = 'Asset long name';
  static const String assetShortName = 'Asset short name';
  static const String transferType = 'transferType';
  static const String recipient = 'recipient';
  static const String noAssets = 'You have no assets :(';
  static const String asset = 'asset';
  static const String mint = 'Mint';
  static const String remint = 'Remint';
  static const String mintAsset = 'Mint Asset';
  static const String sender = 'sender';
  static const String change = 'change';
  static const String fee = 'fee';
  static const String networkId = 'networkId';
  static const String polyAmount = 'polyAmount';
  static const String rawTx = 'rawTx';
  static const String messageToSign = 'messageToSign';
  static const String sign = 'Sign';
  static const String back = 'BACK';
  static const String welcomeToRibn = 'Welcome to Ribn';
  static const String intro = 'Topl’s blockchain wallet for tracking, tokenizing, and transacting impact.';
  static const String getStarted = 'Get Started';
  static const String createWallet = 'CREATE\nWALLET';
  static const String createWalletDescription = 'First time? Create your new wallet\nand 15 word seed phrase.';
  static const String importWallet = 'Import Wallet';
  static const String restoreWalletDescription = 'Restore your existing Ribn wallet\nusing a seed phrase or Topl key.';
  static const String gettingStarted = 'Getting Started';
  static const String download = 'Download';
  static const String gettingStartedDescription =
      '''First, we are going to take you through the process of generating your Seed Phrase. 
This 15-word phrase will be used to restore your assets if this device is lost or damaged!''';
  static const String ok = 'Ok!';
  static const String readCarefully = 'Read Carefully';
  static const String readCarefullyPointOne = '''I understand that I should never share my seed phrase with anyone. 
Anyone with this information can steal the contents of my wallet.''';
  static const String readCarefullyPointTwo =
      '''I understand that if I need to reinstall Ribn on this or another device, 
my wallet contents can only be recovered by using my seed phrase.''';
  static const String iUnderstand = 'I Understand';
  static const String letsGo = "Let's Go!";

  static const String weRecommend = 'We Recommend:';
  static const String weRecommendSub = 'At least one of the following to record your seed phrase safely:';
  static const String paperAndPen = 'A paper and pen.';
  static const String securePasswordManager = 'A secure password manager.';
  static const String encryptTextFile = 'A program such as PGP to encrypt your text file.';
  static const String writeDownSeedPhrase = 'Write Down Seed Phrase';
  static const String seedPhraseFileName = 'seed_phrase';
  static const String letsTryThatAgain = 'Now, Let’s Try That Again';
  static const String heyIWasntKidding =
      '''Hey I wasn’t kidding, write these words down in the exact order they are shown. Remember don’t take any screenshots!''';
  static const String writeDownSeedPhraseDesc = '''Now, you will write each word of your Seed Phrase down carefully.
Make sure they are in the exact order shown below. Don’t take screenshots!''';
  static const String done = 'DONE';
  static const String confirmYourSeedPhrase = 'Confirm your Seed Phrase';
  static const String confirmYourSeedPhraseDesc = 'Click each word in the correct order.';
  static const String seedPhraseConfirmed = 'Seed Phrase Confirmed!';
  static const String seedPhraseConfirmedDesc = '''Good job! Each word in your Seed Phrase has been input correctly. 
Rest assured, you have saved the correct words, in the correct order.''';
  static const String cont = 'Continue';
  static const String finalReview = 'FINAL REVIEW';
  static const String createWalletPassword = 'Create Wallet Password';
  static const String createWalletPasswordDesc = '''Last step, we will create a Wallet Password. 
A Wallet Password is used to unlock your wallet.''';
  static const String newPassword = 'New Password';
  static const String confirmPassword = 'Confirm Password';
  static const String atLeast12Chars = 'At least 12 characters.';
  static const String passwordsMustMatch = 'Both passwords must match.';
  static const String createPassword = 'Create Password';
  static const String readAndAgreedToU = 'I have read and agreed to the ';
  static const String readFollowingCarefully = 'Read Following Carefully';
  static const String readFollowingCarefullyPointOne =
      'I have saved my Wallet Password safely. I will use this password to unlock my wallet.';
  static const String readFollowingCarefullyPointTwo =
      'I understand that Topl cannot recover my Wallet Password for me.';
  static const String readFollowingCarefullyPointThree =
      'I understand that my Seed phrase and Wallet Password are both unrecoverable.';
  static const String walletCreated = '''Success!\nWallet Created''';
  static const String walletCreatedDesc =
      '''You’re all set. Make sure to keep your 15 word Seed phrase safe and private. 
You'll need it to recover your wallet if your device is lost or broken.''';
  static const String frequentlyAskedQuestions = 'Frequently Asked Questions:';
  static const String howCanIKeepMySeedPhraseSecure = 'How can I keep my Seed Phrase secure?';
  static const String howCanIKeepMySeedPhraseSecureAns =
      '''• Save in a password manager.\n• Keep in a safe deposit box.\n• Encrypt and store on an external drive.''';
  static const String howIsASeedPhraseDifferent = 'How is a Seed Phrase different from a Wallet Password?';
  static const String howIsASeedPhraseDifferentAns =
      '''The Seed Phrase is different because you can restore your wallet with it. The Wallet Password is for security and only lets you unlock the wallet after it has been imported (or created) in wallet software. Your Wallet Password isn't required to lock your wallet.''';
  static const String howIsMySeedPhraseUnrecoverable = 'How is my Seed Phrase or Wallet Password unrecoverable?';
  static const String howIsMySeedPhraseUnrecoverableAns =
      '''You are the only one with a record of your Seed Phrase or Wallet Password. Topl does not maintain or have any way to generate either of these for you.''';
  static const String howIsMySeedPhraseUnrecoverableNewLine =
      '''You are the only one with a record of your Seed Phrase or Wallet Password.\nTopl does not maintain or have any way to generate either of these for you.''';

  static const String seedPhraseGenerating = 'Seed Phrase Generating...';
  static const String goGrabAPenAndPaper = 'Go grab a pen and paper';
  static const String seriouslyGetAPenAndPaper = 'Seriously, get a pen and paper';
  static const String aboutToShowSeedPhrase = '''We are about to show you 15 words.
These words need to be written down carefully and in the exact order shown.''';
  static const String seedPhraseGenerated = 'Seed Phrase Generated!';
  static const String seedPhraseGeneratedDesc =
      '''Now that your Seed Phrase has been generated you will be writing the 15 words on a piece of paper. Write down the each word in the exact order it is presented.''';
  static const String generateSeedPhrase = 'GENERATE SEED PHRASE';
  static const String writeDown = 'WRITE DOWN SEED PHRASE';
  static const String confirmSeedPhrase = 'CONFIRM SEED PHRASE';
  static const String ribnWallet = 'Ribn Wallet';
  static const String openTheWalletBy = 'Open the RibnWallet extension by:';
  static const String clickingTheIconPartOne = 'Clicking the ';
  static const String clickingTheIconPartTwo = ''' icon on the top right of your browser.\n\nOr, clicking the ''';
  static const String clickingTheIconPartThree = ' to find the RibnWallet extension in the Chrome extension list.';
  static const String ribnVersion = 'Ribn Version';
  static const String links = 'Links';
  static const String termsOfUse = 'Terms of Use';
  static const String privacyPolicy = 'Privacy Policy';
  static const String export = 'Export';
  static const String exportToplMainKey = 'Export Topl Main Key';
  static const String exportToplMainKeyDesc =
      '''Export Topl Main Key and save it somewhere secure.\nYou can reimport this to restore your wallet.''';
  static const String exportWallet = 'Export Wallet';
  static const String dangerZone = 'Danger Zone';
  static const String actionNotReversible = 'Careful, this action is not reversible!';
  static const String deleteWallet = 'Delete Wallet';
  static const String deleteRibnWallet = 'Delete Ribn Wallet';
  static const String deleteRibnWalletDesc =
      'Enter your wallet password to delete this wallet.\n\nThis action is not reversible. Your Ribn wallet will be deleted from this device.';
  static const String noIChangedMyMind = 'NO, I CHANGED MY MIND!';
  static const String yesIWantToDelete = 'YES, I WANT TO DELETE.';
  static const String enterWalletPassword = 'Enter Wallet Password';
  static const String unlock = 'UNLOCK';
  static const String next = 'NEXT';
  static const String useSeedPhrase = 'USE\nSEED\nPHRASE';
  static const String importToplKey = 'IMPORT\nTOPL\nKEY';
  static const String restoreWallet = 'RESTORE WALLET';
  static const String restoreWalletNewline = 'RESTORE\nWALLET';
  static const String restoreWalletDesc =
      'You can either use your 15-word Seed Phrase or your Top Level Key to import or recover your wallet.';
  static const String seedPhraseDiffFromTopLevelKey = 'How is a Seed Phrase different from a Top Level Key?';

  static const String seedPhraseDiffFromTopLevelKeyDesc =
      '''Your Seed Phrase is a combination of words that you can use to maintain accounts across multiple blockchains including Topl's. Meanwhile, your Top Level Key is a unique key file, specific to the Topl Blockchain. Either one can be used to access your wallet.''';
  static const String whereCanIFindMyTopLevelKey = 'Where can I find my Top Level Key?';
  static const String whereCanIFindMyTopLevelKeyDesc =
      '''You can find and export your Top Level Key under settings. Please make sure to save this in a secure location as we cannot provide it to you if you lose access to your wallet.''';
  static const String hintSeedPhrase =
      'dog jump foot stack hay country fun tree cloud ocean bear alaska fish red sushi';
  static const String restoreWalletSeedPhraseDesc =
      '''Let’s restore your wallet! Enter your 15-word Seed Phrase that you wrote down when you first created your wallet. ''';
  static const String restoreWalletToplKeyDesc =
      '''First, upload your Topl Main Key to import or restore your wallet. Please upload your file in JSON format only.''';

  static const String needHelp = 'Need help? Contact ';
  static const String ribnSupport = 'Ribn Support';
  static const String importWalletUsingSeedPhrase = 'Import Wallet using Seed Phrase';
  static const String typeSomething = 'Type Something';
  static const String supportEmail = 'support@topl.me';
  static const String supportEmailLink = 'mailto:$supportEmail?subject=Ribn Support&body=';
  static const String sendAssets = 'SEND ASSETS';
  static const String yourRibnWalletAddress = 'Your Ribn Wallet address';
  static const String yourIssuerAddress = 'Your issuer address';
  static const String review = 'REVIEW';
  static const String noteHint = 'Origin Brazil, max 127 characters';
  static const String assetTransferToHint = 'Paste Recipient’s address.';
  static const String assetLongNameHint = 'Jackfruit, max 16 characters.';
  static const String assetShortNameHint = 'YLW JACK2, max 8 characters.';
  static const String amountHint = '200000';
  static const String totalTxFee = 'Total Transaction Fee';
  static const String cancel = 'CANCEL';
  static const String confirm = 'CONFIRM';
  static const String sending = 'Sending';
  static const String from = 'From';
  static const String to = 'To';
  static const String note = 'Note';
  static const String txWasBroadcasted = 'Your transaction was broadcasted!';
  static const String assetIsBeingMinted = 'Your Asset is being minted!';
  static const String viewInToplExplorer = 'View in Topl explorer';
  static const String youSend = 'You Send';
  static const String letsMintANewAsset =
      '''Let’s Mint a new Asset!\n\nYou can either mint a new Asset or remint an exisiting Asset.''';
  static const String whatWouldYouLikeToDo = 'What would you like to do?';
  static const String mintNewAsset = 'MINT\nNEW\nASSET';
  static const String remintSameAsset = 'REMINT\nSAME ASSET';
  static const String myRibnWallet = 'MY\nRIBN WALLET';
  static const String anotherRecipientsWallet = 'ANOTHER RECIPIENT\'S WALLET ';
  static const String mintAssetDesc = 'Where would you like your Asset to be minted?';
  static const String issuerAddress = 'Issuer address';
  static const String walletPasswordInfo =
      'Your Wallet Password can lock and unlock your\nwallet on a device where it is already stored.';
  static const String assetLongNameInfo =
      'The descriptive name used to identify your\nassets locally in your Ribn Wallet.';
  static const String assetCodeLongInfo = 'AssetCode serves as a unique identifier\nfor user issued assets.';
  static const String assetCodeShortInfo =
      'This is used to view the short name for your \nasset as this will be the information used to\nidentify a particular asset on the blockchain.';
  static const String issuerAddressInfo =
      'This is the address of the party who originally\ncreated a certain asset. You can copy the\nissuer address and paste it into the Topl explorer\nfor more information.';
  static const String assetDetails = 'Asset Details';
  static const String newWalletPassword = 'New Wallet Password';
  static const String newWalletPasswordHint = 'Min 12 characters';
  static const String confirmWalletPassword = 'Confirm Wallet Password';
  static const String confirmWalletPasswordHint = 'Re-type your Wallet Password';
  static const String warning = 'Warning';
  static const String restoreWalletWarning =
      '''For your security, restoration of a wallet will overwrite all previously stored Ribn activity. This will not affect any activity recorded on the blockchain itself.''';
  static const String enterSeedPhrase = 'Enter Seed Phrase';
  static const String chooseMethod = 'Choose Method';
  static const String errorTitle = 'Oops!\nSomething went wrong';
  static const String errorDescription =
      '''Ribn failed to reach the internet. This could be related to wifi connectivity or network issues.\n\nCheck your internet connection and try again, or contact the Ribn support team.''';
  static const String contactSupport = 'Contact Support';
  static const String tryAgain = 'Try Again';
  static const String returnHome = 'Return Home';
  static const String advancedOption = 'Advanced option';
  static const String useToplMainKey = 'USE TOPL MAIN KEY';
  static const String uploadFile = 'Upload File';
  static const String browse = 'BROWSE';
  static const String enterWalletPasswordToRestoreWallet =
      'Now, enter your Wallet Password to restore your Ribn wallet!';
  static const String restoreWalletReadCarefully =
      'For your security, restoration of a wallet will overwrite all previously stored Ribn activity. This will not affect any activity recorded on the blockchain itself.';
  static const String myRibnWalletAddress = 'My Ribn Wallet Address';
  static const String copyAddress = 'Copy address';
  static const String privacyPolicyUrl = 'https://legal.topl.co/Privacy_Policy';
  static const String termsOfUseUrl = 'https://legal.topl.co/Ribn_License_Agreement';
  static const String loginPasswordInfo =
      'Your Wallet Password can lock and unlock your\n wallet on a device where it is already stored.';
  static const String refillCurrentPolyBalance = 'You can refill your Poly balance anytime by\n signing into';
  static const String refillEmptyPolyBalance = 'Time to refill your Poly balance.\nSign into';
}
