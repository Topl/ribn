// // Dart imports:
// import 'dart:convert';
// import 'dart:typed_data';

// // Package imports:
// import 'package:bip_topl/bip_topl.dart';
// import 'package:redux/redux.dart';

// // Project imports:
// import 'package:ribn/actions/keychain_actions.dart';
// import 'package:ribn/actions/misc_actions.dart';
// import 'package:ribn/actions/onboarding_actions.dart';
// import 'package:ribn/constants/routes.dart';
// import 'package:ribn/constants/rules.dart';
// import 'package:ribn/models/app_state.dart';
// import 'package:ribn/platform/platform.dart';
// import 'package:ribn/repositories/onboarding_repository.dart';
// import 'package:ribn/utils.dart';

// // TODO: Remove when finished
// List<Middleware<AppState>> createOnboardingMiddleware(
//   OnboardingRespository onboardingRespository,
// ) {
//   return <Middleware<AppState>>[
//     TypedMiddleware<AppState, GenerateMnemonicAction>(
//       _generateMnemonic(onboardingRespository),
//     ),
//     TypedMiddleware<AppState, CreatePasswordAction>(
//       _createPassword(onboardingRespository),
//     ),
//   ];
// }

// /// Generates mnemonic for the user and redirects to [Routes.onboardingSteps]
// void Function(
//   Store<AppState> store,
//   GenerateMnemonicAction action,
//   NextDispatcher next,
// ) _generateMnemonic(
//   OnboardingRespository onboardingRespository,
// ) {
//   return (store, action, next) async {
//     try {
//       final String mnemonic = onboardingRespository.generateMnemonicForUser();
//       next(MnemonicSuccessfullyGeneratedAction(mnemonic));
//     } catch (e) {
//       next(ApiErrorAction(e.toString()));
//     }
//   };
// }

// /// Generates a [KeyStore] with the provided password and initializes the HdWallet
// void Function(
//   Store<AppState> store,
//   CreatePasswordAction action,
//   NextDispatcher next,
// ) _createPassword(
//   OnboardingRespository onboardingRespository,
// ) {
//   return (store, action, next) async {
//     try {
//       final AppViews currAppView = await PlatformUtils.instance.getCurrentAppView();
//       // create isolate/worker to avoid hanging the UI
//       final Map<String, dynamic> results = jsonDecode(
//         await PlatformWorkerRunner.instance.runWorker(
//           workerScript: currAppView == AppViews.webDebug
//               ? '/web/workers/generate_keystore_worker.js'
//               : '/workers/generate_keystore_worker.js',
//           function: onboardingRespository.generateKeyStore,
//           params: {
//             'mnemonic': store.state.onboardingState.mnemonic!,
//             'password': action.password,
//           },
//         ),
//       );
//       final Uint8List toplExtendedPrvKeyUint8List =
//           uint8ListFromDynamic(results['toplExtendedPrvKeyUint8List']);
//       // if extension: key is temporarily stored in `chrome.storage.session` & session alarm created
//       // if mobile: key is persisted securely in secure storage
//       if (currAppView == AppViews.extension || currAppView == AppViews.extensionTab) {
//         await PlatformLocalStorage.instance.saveKeyInSessionStorage(
//           Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
//         );
//         PlatformUtils.instance.createLoginSessionAlarm();
//       } else if (currAppView == AppViews.mobile) {
//         await PlatformLocalStorage.instance.saveKeyInSecureStorage(
//           Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
//         );
//       }
//       next(
//         InitializeHDWalletAction(
//           toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
//           keyStoreJson: results['keyStoreJson'],
//         ),
//       );
//       next(PersistAppState());
//     } catch (e) {
//       next(ApiErrorAction(e.toString()));
//     }
//   };
// }
