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
  static const String checkPendingRequest = 'checkPendingRequest';
  static const String returnResponse = 'returnResponse';
  static const String signTx = 'signTx';
  static const String enable = 'enable';
  static const String back = 'Back';
  static const String welcomeToRibn = 'Welcome to Ribn';
  static const String intro = 'Topl’s blockchain wallet for tracking, tokenizing, and transacting impact.';
  static const String getStarted = 'Get Started';
  static const String createWallet = 'Create Wallet';
  static const String createWalletDescription = 'This will create your new wallet and 15 word seed phrase.';
  static const String importWallet = 'Import Wallet';
  static const String importWalletDescription = 'Import your existing Ribn wallet using your 15 word seed phrase.';
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
  static const String atLeast8Chars = 'At least 8 characters.';
  static const String oneOrMoreNumbers = '1 or more numbers.';
  static const String oneUpperCaseLetter = '1 upper case letter.';
  static const String oneOrMoreLowerCaseLetters = '1 or more lower case letters.';
  static const String spacesAreNotAllowed = 'Spaces are not allowed.';
  static const String passwordsMustMatch = 'Both passwords must match.';
  static const String createPassword = 'Create Password';
  static const String readAndAgreedToU = 'I have read and agreed to the Terms of Use';
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
      '''Your Seed Phrase essentially is your wallet. From just this piece of information, your entire wallet can be recreated and accessed. Meanwhile, your Wallet Password can only lock and unlock your wallet on a device where it is already stored.''';
  static const String howIsMySeedPhraseUnrecoverable = 'How is my Seed Phrase or Wallet Password unrecoverable?';
  static const String howIsMySeedPhraseUnrecoverableAns =
      '''You are the only one with a record of your Seed Phrase or Wallet Password. Topl does not maintain or have any way to generate either of these for you.''';

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
  static const String exportKeyStore = 'Export Key Store';
  static const String exportKeyStoreDesc =
      '''Export Key Store and save it somewhere secure.\nYou can reimport it to restore your wallet.''';
  static const String exportWallet = 'Export Wallet';
  static const String dangerZone = 'Danger Zone';
  static const String actionNotReversible = 'Careful, this action is not reversible!';
  static const String deleteWallet = 'Delete Wallet';
  static const String enterWalletPassword = 'Enter Wallet Password';
  static const String unlock = 'UNLOCK';
  static const String useSeedPhrase = 'USE SEED PHRASE';
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
  static const String assetCodeShortInfo =
      'This is used to view the short name for your \nasset as this will be the information used to\nidentify a particular asset on the blockchain.';
  static const String issuerAddressInfo =
      'This is the address of the party who originally\ncreated a certain asset. You can copy the\nissuer address and paste it into the Topl explorer\nfor more information.';
  static const String assetDetails = 'Asset Details';
}
