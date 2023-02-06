import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/utils/error_handling_utils.dart';

final appStateProvider = StateNotifierProvider<AppStateNotifier, void>((ref) {
  return AppStateNotifier();
});

class AppStateNotifier extends StateNotifier<void> {
  AppStateNotifier() : super(null);

  Future<dynamic> persistAppState({required AppState appState}) async {
    try {
      // state is not persisted when app opened in debug view
      if (!await isAppOpenedInDebugView()) {
        await MiscRepository().persistAppState(appState.toJson());
      }
    } catch (e) {
      await handleApiError(
        errorMessage: 'Failed to persist state. Error: ${e.toString()}',
      );
    }
  }
}
