import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/providers/store_provider.dart';

class BiometricsClass {
  final authorized;
  final isEnabled;

  BiometricsClass([
    this.authorized = false,
    this.isEnabled = false,
  ]);
}

final biometricsProvider =
    StateNotifierProvider<BiometricsNotifier, AsyncValue<BiometricsClass>>((ref) {
  return BiometricsNotifier(ref);
});

class BiometricsNotifier extends StateNotifier<AsyncValue<BiometricsClass>> {
  final Ref ref;
  BiometricsNotifier(this.ref) : super(AsyncValue.loading());

  updateBiometrics(bool isBiometricsEnabled) {
    final Store<AppState> store = ref.read(storeProvider);

    store.dispatch(
      UpdateBiometricsAction(
        isBiometricsEnabled: isBiometricsEnabled,
      ),
    );
  }

  Future<void> testUpdate() async {
    state = AsyncValue.loading();

    // Do you thing here

    state = AsyncValue.data(BiometricsClass());
  }
}
