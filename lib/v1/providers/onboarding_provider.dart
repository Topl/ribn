// import 'dart:math';

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// Package imports:
import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/models/onboarding_state.dart';
import 'package:ribn/v1/platform/mobile/storage.dart';
import 'package:ribn/v1/platform/mobile/utils.dart';
import 'package:ribn/v1/platform/mobile/worker_runner.dart';
import 'package:ribn/v1/providers/app_state_provider.dart';
import 'package:ribn/v1/providers/keychain_provider.dart';
import 'package:ribn/v1/providers/packages/entropy_provider.dart';
import 'package:ribn/v1/providers/packages/flutter_secure_storage_provider.dart';
import 'package:ribn/v1/providers/packages/random_provider.dart';
import 'package:ribn/v1/repositories/onboarding_repository.dart';
import 'package:ribn/v1/utils/error_handling_utils.dart';
import 'package:ribn/v1/utils/extensions.dart';

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(ref);
});

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref ref;
  OnboardingNotifier(this.ref) : super(_generateOnboardingState(ref)) {}

  static OnboardingState _generateOnboardingState(ref) {
    final String mnemonic = _generateMnemonic(ref);
    final List<String> splitMnemonic = mnemonic.split(' ').toList();
    return OnboardingState(
      mnemonic: mnemonic,
      shuffledMnemonic: splitMnemonic,
    );
  }

  static String _generateMnemonic(Ref ref) {
    final Random random = ref.read(randomProvider)();

    final Entropy entropy = ref.read(entropyProvider)(random);
    return ref.read(entropyFuncProvider)(entropy);
  }

  regenerateMnemonic() {
    final OnboardingState onboardingState = _generateOnboardingState(ref);
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
          (results['toplExtendedPrvKeyUint8List'] as List<dynamic>).toUint8List();

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
            override: ref.read(flutterSecureStorageProvider)());
      }

      await ref.read(keychainProvider.notifier).initializeHdWallet(
            toplExtendedPrivateKey: toplExtendedPrvKeyUint8List,
            keyStoreJson: results['keyStoreJson'],
          );

      await ref.read(appStateProvider.notifier).persistAppState();
    } catch (e) {
      handleApiError(errorMessage: e.toString());
    }
  }
}
