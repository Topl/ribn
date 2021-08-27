import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:ribn/middlewares/app_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/reducers/app_reducer.dart';
import 'package:ribn/js.dart' as js;

class Redux {
  static Store<AppState>? _store;

  static Store<AppState>? get store {
    if (_store == null) {
      throw Exception("Store is not initialized");
    } else {
      return _store;
    }
  }

  /// Fetches [AppState] from the extension's storage and initializes the Redux [_store]
  static Future<void> init() async {
    Map<String, dynamic> persistedAppState = await getPersistedAppState();
    _store = Store<AppState>(
      appReducer,
      middleware: appMiddleware,
      distinct: true,
      initialState: persistedAppState.isNotEmpty ? AppState.fromMap(persistedAppState) : AppState.initial(),
    );
  }

  static Future<Map<String, dynamic>> getPersistedAppState() async {
    try {
      String persistedAppState = await js.getDataFromLocalStorage();
      Map<String, dynamic> mappedAppState = jsonDecode(persistedAppState);
      return mappedAppState;
    } catch (e) {
      return {};
    }
  }
}
