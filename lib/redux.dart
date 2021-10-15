import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/data/data.dart' as local;
import 'package:ribn/middlewares/app_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/reducers/app_reducer.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

class Redux {
  static Store<AppState>? _store;
  static const OnboardingRespository onboardingRespository = OnboardingRespository();
  static const LoginRepository loginRepository = LoginRepository();
  static const MiscRepository miscRepository = MiscRepository();
  static const KeychainRepository keychainRepository = KeychainRepository();
  static const TransactionRepository transactionRepository = TransactionRepository();

  static Store<AppState>? get store {
    if (_store == null) {
      throw Exception("Store is not initialized");
    } else {
      return _store;
    }
  }

  /// Fetches [AppState] from the extension's storage and initializes the Redux [_store]
  static Future<void> initStore({
    OnboardingRespository onboardingRepo = onboardingRespository,
    LoginRepository loginRepo = loginRepository,
    MiscRepository miscRepo = miscRepository,
    KeychainRepository keychainRepo = keychainRepository,
    TransactionRepository transactionRepo = transactionRepository,
  }) async {
    Map<String, dynamic> persistedAppState = await getPersistedAppState();
    _store = Store<AppState>(
      appReducer,
      middleware: createAppMiddleware(
        onboardingRepo: onboardingRepo,
        loginRepo: loginRepo,
        miscRepo: miscRepo,
        keychainRepo: keychainRepo,
        transactionRepo: transactionRepo,
      ),
      distinct: true,
      initialState: persistedAppState.isNotEmpty ? AppState.fromMap(persistedAppState) : AppState.initial(),
    );
  }

  static Future<Map<String, dynamic>> getPersistedAppState() async {
    try {
      final String persistedAppState = await local.getDataFromLocalStorage();
      final Map<String, dynamic> mappedAppState = jsonDecode(persistedAppState) as Map<String, dynamic>;
      return mappedAppState;
    } catch (e) {
      return {};
    }
  }

  /// Initiates a long-lived connection with the background script.
  ///
  /// Also adds a listener for incoming messages.
  static Future<String> initBgConnection() async {
    final Completer<String> completer = Completer<String>();
    try {
      if (await local.openedInExtensionView()) {
        completer.complete('');
      } else {
        local.connectToBackground();
        local.initPortMessageListener(completer.complete);
        local.sendPortMessage(jsonEncode({'method': Strings.checkPendingRequest}));
      }
    } catch (e) {
      completer.complete('');
      local.closeWindow();
    }
    return completer.future;
  }
}
