import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/providers/store_provider.dart';

final appStateProvider = StateNotifierProvider<AppStateNotifier, void>((ref) {
  return AppStateNotifier(ref);
});

class AppStateNotifier extends StateNotifier<void> {
  final Ref ref;
  AppStateNotifier(this.ref) : super(null);

  // TODO: for now this will just reach out to redux. Move to using this provider only in the future
  Future<dynamic> persistAppState() async {
    final store = ref.read(storeProvider);
    await store.dispatch(PersistAppState());
  }
}
