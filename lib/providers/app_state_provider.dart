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

  // TODO: for now this will just reach out to redux. Move to using this provider only in the future
  Future<dynamic> persistAppState() async {}
}
