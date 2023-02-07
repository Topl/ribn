// import 'dart:math';

import 'dart:convert';
import 'dart:typed_data';

import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/onboarding_state.dart';
import 'package:ribn/platform/mobile/storage.dart';
import 'package:ribn/platform/mobile/utils.dart';
import 'package:ribn/platform/mobile/worker_runner.dart';
import 'package:ribn/providers/app_state_provider.dart';
import 'package:ribn/providers/keychain_provider.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/utils/error_handling_utils.dart';
// import 'package:ribn/providers/packages/entropy_provider.dart';
// import 'package:ribn/providers/packages/random_provider.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref ref;
  OnboardingNotifier(this.ref) : super(_generateOnboardingState(ref)) {}

  static OnboardingState _generateOnboardingState(ref) {
    final mnemonic = _generateMnemonic(ref);
    final splitMnemonic = mnemonic.split(' ').toList();
    return OnboardingState(
      mnemonic: mnemonic,
      shuffledMnemonic: splitMnemonic,
    );
  }

  static String _generateMnemonic(ref) {
    // QQQQ change back
    return 'vote initial ship clean pencil genre struggle say hidden later quit scissors sentence illness leaf';
    // final Random random = ref.read(randomProvider)();

    // final entropy = ref.read(entropyProvider)(random);
    // print('QQQQ mnemonic ${ref.read(entropyFuncProvider)(entropy)}');
    // return ref.read(entropyFuncProvider)(entropy);
  }

  regenerateMnemonic() {
    final onboardingState = _generateOnboardingState(ref);
    state = state.copyWith(
      mnemonic: onboardingState.mnemonic,
      shuffledMnemonic: onboardingState.shuffledMnemonic,
    );
  }

  Future<void> createPassword({
    required String password,
  }) async {
    try {
      final AppViews currAppView = await PlatformUtils.instance.getCurrentAppView();

      // create isolate/worker to avoid hanging the UI
      final Map<String, dynamic> results = jsonDecode(
        await PlatformWorkerRunner.instance.runWorker(
          workerScript: currAppView == AppViews.webDebug
              ? '/web/workers/generate_keystore_worker.js'
              : '/workers/generate_keystore_worker.js',
          function: OnboardingRespository().generateKeyStore,
          params: {
            'mnemonic': state.mnemonic,
            'password': password,
          },
        ),
      );

      final Uint8List toplExtendedPrvKeyUint8List =
          uint8ListFromDynamic(results['toplExtendedPrvKeyUint8List']);

      // if extension: key is temporarily stored in `chrome.storage.session` & session alarm created
      // if mobile: key is persisted securely in secure storage
      if (currAppView == AppViews.extension || currAppView == AppViews.extensionTab) {
        await PlatformLocalStorage.instance.saveKeyInSessionStorage(
          Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
        );
        PlatformUtils.instance.createLoginSessionAlarm();
      } else if (currAppView == AppViews.mobile) {
        await PlatformLocalStorage.instance.saveKeyInSecureStorage(
          Base58Encoder.instance.encode(toplExtendedPrvKeyUint8List),
        );
      }

      await ref.read(keychainProvider.notifier).initializeHdWallet(
            toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
            keyStoreJson: results['keyStoreJson'],
          );

      await ref.read(appStateProvider.notifier).persistAppState();

      print('QQQQ end of create');
    } catch (e) {
      handleApiError(errorMessage: e.toString());
    }
  }
}
