import 'dart:async';
import 'dart:typed_data';

import 'package:brambldart/brambldart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
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
  final Uint8List testToplExtendedPrivKey = Uint8List.fromList(toList(testData['toplExtendedPrvKey']!));

  late Store<AppState> testStore;

  Future<void> reset() async {
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
        when(onboardingRepo.generateMnemonicForUser()).thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        verify(onboardingRepo.generateMnemonicForUser()).called(1);
        expect(testStore.state.onboardingState.mnemonic, testMnemonic);
        expect(testStore.state.onboardingState.shuffledMnemonic, unorderedEquals(testMnemonic.split(' ')));
      });
      test('should generate keystore and initialize hd wallet', () {
        when(onboardingRepo.generateMnemonicForUser()).thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        when(
          onboardingRepo.generateKeyStore(
            mnemonic: captureAnyNamed('mnemonic'),
            password: captureAnyNamed('password'),
          ),
        ).thenReturn(
          {
            'keyStoreJson': testKeyStore,
            'toplExtendedPrvKeyUint8List': testToplExtendedPrivKey,
          },
        );
        testStore.dispatch(CreatePasswordAction(validPassword));
        verify(
          onboardingRepo.generateKeyStore(
            mnemonic: captureAnyNamed('mnemonic'),
            password: captureAnyNamed('password'),
          ),
        ).called(1);
        expect(testStore.state.keychainState.keyStoreJson, testKeyStore);
        expect(testStore.state.keychainState.hdWallet, isNotNull);
      });
    });
    group('Login middleware', () {
      setUp(() {
        // generate mnemonic
        when(onboardingRepo.generateMnemonicForUser()).thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        // generate keystore
        when(
          onboardingRepo.generateKeyStore(
            mnemonic: captureAnyNamed('mnemonic'),
            password: captureAnyNamed('password'),
          ),
        ).thenAnswer((_) {
          return const OnboardingRespository().generateKeyStore(
            mnemonic: _.namedArguments[const Symbol('mnemonic')],
            password: _.namedArguments[const Symbol('password')],
          );
        });
        testStore.dispatch(CreatePasswordAction(validPassword));
      });
      test('should decrypt keysotre', () {
        when(
          loginRepo.decryptKeyStore(
            keyStoreJson: captureAnyNamed('keyStoreJson'),
            password: captureAnyNamed('password'),
          ),
        ).thenAnswer(
          (_) => const LoginRepository().decryptKeyStore(
            keyStoreJson: _.namedArguments[const Symbol('keyStoreJson')],
            password: _.namedArguments[const Symbol('password')],
          ),
        );
        final Completer<bool> completer = Completer();
        testStore.dispatch(AttemptLoginAction(validPassword, completer));
        verify(
          loginRepo.decryptKeyStore(
            keyStoreJson: captureAnyNamed('keyStoreJson'),
            password: captureAnyNamed('password'),
          ),
        ).called(1);
        expect(completer.future, completion(true));
      });
      test('should not decrypt keysotre', () {
        when(
          loginRepo.decryptKeyStore(
            keyStoreJson: captureAnyNamed('keyStoreJson'),
            password: captureAnyNamed('password'),
          ),
        ).thenAnswer(
          (_) => const LoginRepository().decryptKeyStore(
            keyStoreJson: _.namedArguments[const Symbol('keyStoreJson')],
            password: _.namedArguments[const Symbol('password')],
          ),
        );
        final Completer<bool> completer = Completer();
        testStore.dispatch(AttemptLoginAction(invalidPassword, completer));
        verify(
          loginRepo.decryptKeyStore(
            keyStoreJson: captureAnyNamed('keyStoreJson'),
            password: captureAnyNamed('password'),
          ),
        ).called(1);
        expect(completer.future, completion(false));
      });
    });

    group('Keychain middleware', () {
      setUp(() {
        // generate mnemonic
        when(onboardingRepo.generateMnemonicForUser()).thenAnswer((_) => testMnemonic);
        testStore.dispatch(GenerateMnemonicAction());
        // generate keystore
        when(
          onboardingRepo.generateKeyStore(
            mnemonic: captureAnyNamed('mnemonic'),
            password: captureAnyNamed('password'),
          ),
        ).thenReturn({'keyStoreJson': testKeyStore, 'toplExtendedPrvKeyUint8List': testToplExtendedPrivKey});
        testStore.dispatch(CreatePasswordAction(validPassword));
        // login
        when(
          loginRepo.decryptKeyStore(
            keyStoreJson: captureAnyNamed('keyStoreJson'),
            password: captureAnyNamed('password'),
          ),
        ).thenReturn(testToplExtendedPrivKey);
      });
      test('Generate initial addresses', () {
        when(keychainRepo.generateAddress(captureAny, networkId: captureAnyNamed('networkId')))
            .thenAnswer((_) => MockRibnAddress());
        testStore.dispatch(GenerateInitialAddressesAction());
        testStore.state.keychainState.allNetworks.toList().forEach((network) {
          expect(network.addresses, hasLength(1));
        });
      });

      test('Should refresh balances', () async {
        const testPolys = 10000;
        when(keychainRepo.generateAddress(captureAny, networkId: captureAnyNamed('networkId')))
            .thenAnswer((_) => testAddress);
        testStore.dispatch(GenerateInitialAddressesAction());
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
        testStore.dispatch(RefreshBalancesAction(completer));
        await expectLater(completer.future, completion(true));
        expect(
          testStore.state.keychainState.currentNetwork.addresses.first.balance.polys,
          PolyAmount.inNanopoly(quantity: testPolys),
        );
      });
    });
  });
}
