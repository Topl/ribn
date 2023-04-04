// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/redux.dart';

final storeProvider = Provider<Store<AppState>>((ref) {
  return Redux.store!;
});
