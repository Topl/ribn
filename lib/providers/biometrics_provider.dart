import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/providers/store_provider.dart';

final biometricsProvider = StateNotifierProvider<BiometricsNotifier, void>((ref) {
  return BiometricsNotifier(ref);
});

class BiometricsNotifier extends StateNotifier<void> {
  final Ref ref;
  BiometricsNotifier(this.ref) : super(null);

  updateBiometrics(bool isBiometricsEnabled) {
    final store = ref.read(storeProvider);

    store.dispatch(
      UpdateBiometricsAction(
        isBiometricsEnabled: isBiometricsEnabled,
      ),
    );
  }
}
