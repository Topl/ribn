// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/middlewares/app_middleware.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/platform/platform.dart';
import 'package:ribn/v1/reducers/app_reducer.dart';
import 'package:ribn/v1/repositories/keychain_repository.dart';
import 'package:ribn/v1/repositories/login_repository.dart';
import 'package:ribn/v1/repositories/misc_repository.dart';
import 'package:ribn/v1/repositories/onboarding_repository.dart';
import 'package:ribn/v1/repositories/transaction_repository.dart';

class Redux {
  static Store<AppState>? _store;
  static const OnboardingRespository onboardingRepository = OnboardingRespository();
  static const LoginRepository loginRepository = LoginRepository();
  static const MiscRepository miscRepository = MiscRepository();
  static const KeychainRepository keychainRepository = KeychainRepository();
  static const TransactionRepository transactionRepository = TransactionRepository();

  static Store<AppState>? get store {
    if (_store == null) {
      throw Exception('Store is not initialized');
    } else {
      return _store;
    }
  }

  /// Fetches [AppState] from the extension's storage and initializes the Redux [_store]
  static Future<void> initStore({
    bool initTestStore = false,
    OnboardingRespository onboardingRepo = onboardingRepository,
    LoginRepository loginRepo = loginRepository,
    MiscRepository miscRepo = miscRepository,
    KeychainRepository keychainRepo = keychainRepository,
    TransactionRepository transactionRepo = transactionRepository,
  }) async {
    final AppState appState = await getInitialAppState(initTestStore);
    _store = Store<AppState>(
      appReducer,
      middleware: createAppMiddleware(
        onboardingRepo: onboardingRepo,
        miscRepo: miscRepo,
        keychainRepo: keychainRepo,
        transactionRepo: transactionRepo,
      ),
      distinct: true,
      initialState: appState,
    );
  }

  static Future<Map<String, dynamic>> getPersistedAppState() async {
    try {
      final String persistedAppState = await PlatformLocalStorage.instance.getState();
      final Map<String, dynamic> mappedAppState = jsonDecode(persistedAppState) as Map<String, dynamic>;
      return mappedAppState;
    } catch (e) {
      return {};
    }
  }

  /// Gets the persisted app state from local storage, and if valid, initializes AppState with the persisted state.
  /// Otherwise, a new AppState is initialized depending on [initTestStore].
  static Future<AppState> getInitialAppState(bool initTestStore) async {
    try {
      final Map<String, dynamic> appState = await getPersistedAppState();
      if (kIsWeb) {
        final String? toplKey = await PlatformLocalStorage.instance.getKeyFromSessionStorage();
        appState['keychainState']['toplKey'] = toplKey;
      }
      return AppState.fromMap(appState);
    } catch (e) {
      return initTestStore ? AppState.test() : AppState.initial();
    }
  }
}
