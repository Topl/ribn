// ignore_for_file: unused_import

import 'dart:typed_data';
import 'package:bip_topl/bip_topl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/redux.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:mubrambl/src/credentials/address.dart';
import 'shared_mocks.mocks.dart';
import 'test_data.dart';

void main() {
  final MockOnboardingRespository onboardingRepo = MockOnboardingRespository();
  final MockLoginRepository loginRepo = MockLoginRepository();
  final MockKeychainRepository keychainRepo = MockKeychainRepository();

  final Uint8List testToplExtendedPrivKey = Uint8List.fromList(toList(testData["toplExtendedPrvKey"]!));
  final String validPassword = testData["validPassword"]!;
  final String shortPassword = testData["shortPassword"]!;
  final String testKeyStore = testData["keyStoreJson"]!;

  group("App middleware", () {
    setUp(() async {
      resetMockitoState();
      await Redux.init(
        onboardingRepo: onboardingRepo,
        loginRepo: loginRepo,
        keychainRepo: keychainRepo,
      );
    });
    group("Onboarding middleware", () {
      test("password too short error", () {
        final Store<AppState> testStore = Redux.store!;
        testStore.dispatch(CreatePasswordAction(shortPassword, shortPassword));
        verifyNoMoreInteractions(onboardingRepo);
        expect(testStore.state.onboardingState.passwordTooShortError, true);
      });
      test("password mismatch error", () {
        final Store<AppState> testStore = Redux.store!;
        testStore.dispatch(CreatePasswordAction(shortPassword, validPassword));
        verifyNoMoreInteractions(onboardingRepo);
        expect(testStore.state.onboardingState.passwordMismatchError, true);
      });
      test("mnemonic and keystore generation on valid password", () async {
        final Store<AppState> testStore = Redux.store!;
        testStore.dispatch(CreatePasswordAction(validPassword, validPassword));
        verify(onboardingRepo.generateMnemonicAndKeystore(validPassword)).called(1);
      });
    });
    group("Login middleware", () {
      test("login with incorrect password", () {
        final Store<AppState> testStore = Redux.store!;
        when(loginRepo.decryptKeyStore(
          captureThat(const TypeMatcher<String>()),
          captureThat(const TypeMatcher<String>()),
        )).thenAnswer((_) {
          throw (ArgumentError("supplied the wrong password"));
        });
        testStore.dispatch(AttemptLoginAction(validPassword, testKeyStore));
        verify(loginRepo.decryptKeyStore(testKeyStore, validPassword)).called(1);
        expect(testStore.state.loginState.isLoggedIn, false);
        expect(testStore.state.loginState.incorrectPasswordError, true);
      });

      test("login with correct password", () {
        final Store<AppState> testStore = Redux.store!;
        when(loginRepo.decryptKeyStore(
          captureThat(const TypeMatcher<String>()),
          captureThat(const TypeMatcher<String>()),
        )).thenAnswer((_) => testToplExtendedPrivKey);
        testStore.dispatch(AttemptLoginAction(validPassword, testKeyStore));
        verify(loginRepo.decryptKeyStore(testKeyStore, validPassword)).called(1);
        expect(testStore.state.loginState.isLoggedIn, true);
      });
    });
    group("keychain middleware", () {
      test("initial addresses generation", () {
        final Store<AppState> testStore = Redux.store!;
        when(keychainRepo.generateAddress(captureAny, addr: captureAnyNamed('addr')))
            .thenAnswer((_) => MockRibnAddress());
        MockHdWallet hdWallet = MockHdWallet();
        testStore.dispatch(GenerateInitialAddressesAction(hdWallet));
        verifyInOrder([
          keychainRepo.generateAddress(hdWallet, addr: 0),
          keychainRepo.generateAddress(hdWallet, addr: 1),
          keychainRepo.generateAddress(hdWallet, addr: 2),
          keychainRepo.generateAddress(hdWallet, addr: 3),
          keychainRepo.generateAddress(hdWallet, addr: 4),
        ]);
        expect(testStore.state.keychainState.addresses, hasLength(Rules.numInitialAddresses));
      });
      test("address generation", () async {
        final Store<AppState> testStore = Redux.store!;
        MockHdWallet hdWallet = MockHdWallet();
        MockRibnAddress ribnAddress = MockRibnAddress();
        when(keychainRepo.generateAddress(captureAny, addr: captureAnyNamed('addr')))
            .thenAnswer((_) => ribnAddress);
        testStore.dispatch(GenerateAddressAction(0, hdWallet));
        verify(keychainRepo.generateAddress(captureAny, addr: captureAnyNamed('addr'))).called(1);
        expect(testStore.state.keychainState.addresses, anyElement(ribnAddress));
      });
    });
  });
}
