import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/redux.dart';

final storeProvider = Provider<Store<AppState>>((ref) {
  return Redux.store!;
});