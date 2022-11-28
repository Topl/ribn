/// @dev File contains function that setups any singletons required within the app

import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';

import '../../../models/app_state.dart';

final locator = GetIt.instance;
void setupLocator(Store<AppState> store) {
  locator.registerSingleton<Store<AppState>>(store, signalsReady: true);
}
