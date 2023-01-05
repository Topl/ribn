// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/test_data.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'shared_mocks.mocks.dart';
import 'test_data.dart';

void main() {
  final MockOnboardingRespository onboardingRepo = MockOnboardingRespository();
  final MockLoginRepository loginRepo = MockLoginRepository();
  final MockKeychainRepository keychainRepo = MockKeychainRepository();
  final MockMiscRepository miscRepo = MockMiscRepository();
  final MockTransactionRepository transactionRepo = MockTransactionRepository();

  final String testMnemonic = testData['mnemonic']!;
  final String validPassword = testData['validPassword']!;
  final String invalidPassword = testData['invalidPassword']!;
  final String testKeyStore = testData['keyStoreJson']!;
  final RibnAddress testAddress = testData['address'];
  final Uint8List testToplExtendedPrivKey =
      Uint8List.fromList(toList(testData['toplExtendedPrvKey']!));

  late Store<AppState> testStore;

  Future<void> reset() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    resetMockitoState();
    await Redux.initStore(
      onboardingRepo: onboardingRepo,
      loginRepo: loginRepo,
      keychainRepo: keychainRepo,
      miscRepo: miscRepo,
      transactionRepo: transactionRepo,
    );
    testStore = Redux.store!;
  }

  group('App middleware', () {
    setUp(reset);
    group('Onboarding middleware', () {
      test('should generate mnemonic', () {
        when(onboardingRepo.generateMnemonicForUser())
            .thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        verify(onboardingRepo.generateMnemonicForUser()).called(1);
        expect(testStore.state.onboardingState.mnemonic, testMnemonic);
        expect(testStore.state.onboardingState.shuffledMnemonic,
            unorderedEquals(testMnemonic.split(' ')),);
      });
      test('should generate keystore and initialize hd wallet', () async {
        when(onboardingRepo.generateMnemonicForUser())
            .thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        // mnemonic: captureAnyNamed('mnemonic'),
        // password: captureAnyNamed('password'),
        when(
          onboardingRepo.generateKeyStore(argThat(isNotNull)),
        ).thenReturn(
          {
            'keyStoreJson': testKeyStore,
            'toplExtendedPrvKeyUint8List': testToplExtendedPrivKey,
          },
        );
        testStore.dispatch(CreatePasswordAction(validPassword));
        // verifyas(
        //   onboardingRepo.generateKeyStore(argThat(isNotNull)
        //       // mnemonic: captureAnyNamed('mnemonic'),
        //       // password: captureAnyNamed('password'),
        //       ),
        // ).called(1);
        await Future.delayed(
          const Duration(seconds: 1),
          (() {
            expect(testStore.state.keychainState.keyStoreJson, testKeyStore);
            expect(testStore.state.keychainState.hdWallet, isNotNull);
          }),
        );
      });
    });
    group('Login middleware', () {
      setUp(() {
        // generate mnemonic
        when(onboardingRepo.generateMnemonicForUser())
            .thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        // generate keystore
        when(
          onboardingRepo.generateKeyStore(argThat(isNotNull)),
        ).thenAnswer((_) {
          return const OnboardingRespository().generateKeyStore({
            'mnemonic': _.positionalArguments[0]['mnemonic'],
            'password': _.positionalArguments[0]['password'],
          });
        });
        testStore.dispatch(CreatePasswordAction(validPassword));
      });
      test('should decrypt keystore', () async {
        when(
          loginRepo.decryptKeyStore(argThat(isNotNull)),
        ).thenAnswer((_) {
          return const LoginRepository().decryptKeyStore({
            'keyStoreJson': testKeyStore,
            'password': validPassword,
          });
        });
        final Completer<bool> completer = Completer();
        testStore.dispatch(AttemptLoginAction(validPassword, completer));
        await expectLater(completer.future, completion(true));
      });
      test('should not decrypt keysotre', () {
        when(
          loginRepo.decryptKeyStore(argThat(isNotNull)),
        ).thenAnswer(
          (_) => const LoginRepository().decryptKeyStore(
              {'keyStoreJson': testKeyStore, 'password': invalidPassword},),
        );
        final Completer<bool> completer = Completer();
        testStore.dispatch(AttemptLoginAction(invalidPassword, completer));
        verify(
          loginRepo.decryptKeyStore(argThat(isNotNull)),
        ).called(1);
        expect(completer.future, completion(false));
      });
    });

    group('Keychain middleware', () {
      setUp(() {
        // generate mnemonic
        when(onboardingRepo.generateMnemonicForUser())
            .thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        // generate keystore
        when(onboardingRepo.generateKeyStore(argThat(isNotNull))).thenReturn({
          'keyStoreJson': testKeyStore,
          'toplExtendedPrvKeyUint8List': testToplExtendedPrivKey
        });
        testStore.dispatch(CreatePasswordAction(validPassword));
        // login
        when(loginRepo.decryptKeyStore(captureAny))
            .thenReturn(testToplExtendedPrivKey);
      });
      test('Should refresh balances', () async {
        const testPolys = 10000;
        await Future.delayed(
          Duration.zero,
          () => testStore.dispatch(
            InitializeHDWalletAction(
                toplExtendedPrivateKey: TestData.toplExtendedPrvKeyUint8List,),
          ),
        );
        when(keychainRepo.generateAddress(argThat(isNotNull),
                networkId: captureAnyNamed('networkId'),),)
            .thenAnswer((_) => testAddress);
        testStore.dispatch(GenerateAddressAction(0,
            network: testStore.state.keychainState.currentNetwork,),);
        when(keychainRepo.getBalances(captureAny, captureAny)).thenAnswer((_) {
          return Future.value(
            (_.positionalArguments[1] as List<ToplAddress>)
                .map(
                  (e) => Balance(
                    address: e.toBase58(),
                    polys: PolyAmount.inNanopoly(quantity: testPolys),
                    arbits: ArbitAmount.zero(),
                  ),
                )
                .toList(),
          );
        });
        final Completer<bool> completer = Completer();
        testStore.dispatch(RefreshBalancesAction(
            completer, testStore.state.keychainState.currentNetwork,),);
        await expectLater(completer.future, completion(true));
        expect(
          testStore
              .state.keychainState.currentNetwork.addresses.first.balance.polys,
          PolyAmount.inNanopoly(quantity: testPolys),
        );
      });
    });
  });
}
