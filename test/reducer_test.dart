import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/redux.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:bip_topl/bip_topl.dart';
import 'shared_mocks.mocks.dart';
import 'test_data.dart';

void main() {
  group("AppState reducer", () {
    final String testMnemonic = testData["mnemonic"]!;
    final String testKeyStore = testData["keyStoreJson"]!;
    final Uint8List testToplExtendedPrivKey = Uint8List.fromList(toList(testData["toplExtendedPrvKey"]!));
    setUp(() async {
      await Redux.init();
    });

    group("Onboarding reducer", () {
      test("password successfully created", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(PasswordSuccessfullyCreatedAction(testMnemonic));
        expect(testStore.state.onboardingState.mnemonic, testMnemonic);
        expect(testStore.state.onboardingState.passwordMismatchError, false);
        expect(testStore.state.onboardingState.passwordTooShortError, false);
        expect(testStore.state.onboardingState.loadingPasswordValidation, false);
        expect(
          testStore.state.onboardingState.shuffledMnemonic,
          unorderedEquals(List.from(testMnemonic.split(" "))),
        );
        expect(testStore.state.onboardingState.userSelectedIndices, isEmpty);
      });
      test("password mismatch ", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(PasswordMismatchAction());
        expect(testStore.state.onboardingState.passwordMismatchError, true);
        expect(testStore.state.onboardingState.passwordTooShortError, false);
        expect(testStore.state.onboardingState.loadingPasswordValidation, false);
      });
      test("loading password validation", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(LoadingPasswordValidationAction());
        expect(testStore.state.onboardingState.loadingPasswordValidation, true);
      });
      test("password too short", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(PasswordTooShortAction());
        expect(testStore.state.onboardingState.passwordTooShortError, true);
        expect(testStore.state.onboardingState.loadingPasswordValidation, false);
        expect(testStore.state.onboardingState.passwordMismatchError, false);
      });
      test("password too short", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(PasswordTooShortAction());
        expect(testStore.state.onboardingState.passwordTooShortError, true);
        expect(testStore.state.onboardingState.loadingPasswordValidation, false);
        expect(testStore.state.onboardingState.passwordMismatchError, false);
      });
      test("mnemonic successfully verified", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(MnemonicSuccessfullyVerifiedAction());
        expect(testStore.state.onboardingState.mnemonicMismatchError, false);
        expect(testStore.state.onboardingState.mnemonic, isNull);
        expect(testStore.state.onboardingState.shuffledMnemonic, isNull);
        expect(testStore.state.onboardingState.userSelectedIndices, isNull);
      });

      test("mnemonic mismatch error", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(MnemonicMismatchAction());
        expect(testStore.state.onboardingState.mnemonicMismatchError, true);
      });
      test("user selected word", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(const UserSelectedWordAction(1));
        expect(testStore.state.onboardingState.userSelectedIndices, anyElement(1));
      });
      test("user removed word", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(const UserRemovedWordAction(1));
        expect(testStore.state.onboardingState.userSelectedIndices, isNot(anyElement(1)));
      });
    });
    group("Login reducer", () {
      test("first time login", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(FirstTimeLoginAction());
        expect(testStore.state.loginState.incorrectPasswordError, false);
        expect(testStore.state.loginState.loadingPasswordCheck, false);
        expect(testStore.state.loginState.isLoggedIn, true);
        expect(testStore.state.loginState.lastLogin, isNotNull);
        expect(testStore.state.loginState.firstTimeLogin, isNotNull);
      });
      test("login success", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(const LoginSuccessAction());
        expect(testStore.state.loginState.incorrectPasswordError, false);
        expect(testStore.state.loginState.loadingPasswordCheck, false);
        expect(testStore.state.loginState.isLoggedIn, true);
        expect(testStore.state.loginState.lastLogin, isNotNull);
      });
      test("login failure", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(LoginFailureAction());
        expect(testStore.state.loginState.incorrectPasswordError, true);
        expect(testStore.state.loginState.isLoggedIn, false);
        expect(testStore.state.loginState.loadingPasswordCheck, false);
      });
      test("login loading", () async {
        Store<AppState> testStore = Redux.store!;
        testStore.dispatch(LoginLoadingAction());
        expect(testStore.state.loginState.incorrectPasswordError, false);
        expect(testStore.state.loginState.isLoggedIn, false);
        expect(testStore.state.loginState.loadingPasswordCheck, true);
      });
    });
    group("Keychain reducer", () {
      test("hd wallet initialization", () async {
        Store<AppState> testStore = Redux.store!;
        HdWallet hdWallet = HdWallet(
          rootSigningKey: Bip32SigningKey.fromValidBytes(
            testToplExtendedPrivKey,
            depth: Rules.toplKeyDepth,
          ),
        );
        testStore.dispatch(InitializeHDWalletAction(
          keyStoreJson: testKeyStore,
          toplExtendedPrivateKey: testToplExtendedPrivKey,
        ));
        expect(testStore.state.keychainState.hdWallet!.rootSigningKey, hdWallet.rootSigningKey);
        expect(testStore.state.keychainState.keyStoreJson, testKeyStore);
      });
      test("add address", () async {
        Store<AppState> testStore = Redux.store!;
        MockRibnAddress ribnAddress = MockRibnAddress();
        testStore.dispatch(AddAddressesAction(addresses: [ribnAddress]));
        expect(testStore.state.keychainState.addresses, anyElement(ribnAddress));
      });
    });
  });
}
