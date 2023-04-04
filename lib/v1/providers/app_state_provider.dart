// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/misc_actions.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/providers/store_provider.dart';

final appStateProvider = StateNotifierProvider<AppStateNotifier, void>((ref) {
  return AppStateNotifier(ref);
});

class AppStateNotifier extends StateNotifier<void> {
  final Ref ref;
  AppStateNotifier(this.ref) : super(null);

  // TODO: for now this will just reach out to redux. Move to using this provider only in the future
  Future<dynamic> persistAppState() async {
    final Store<AppState> store = ref.read(storeProvider);
    await store.dispatch(PersistAppState());
  }

  Future<void> resetAppState() async {
    final Store<AppState> store = ref.read(storeProvider);
    await store.dispatch(ResetAppStateAction());
  }
}
