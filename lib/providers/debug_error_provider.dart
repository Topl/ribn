import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/state/debug_error_model.dart';

final debugErrorProvider = StateNotifierProvider<DebugErrorNotifier, List<DebugErrorModel>>((ref) {
  return DebugErrorNotifier();
});

class DebugErrorNotifier extends StateNotifier<List<DebugErrorModel>> {
  DebugErrorNotifier() : super([]);

  void addDebugError(String errorMessage) {
    print('QQQQ addDebugError: $errorMessage');
    state = [
      ...state,
      DebugErrorModel(errorMessage: errorMessage),
    ];
  }
}
