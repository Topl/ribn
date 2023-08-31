import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentIndexNotifier extends StateNotifier<int> {
  CurrentIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final currentIndexProvider = StateNotifierProvider<CurrentIndexNotifier, int>((ref) {
  return CurrentIndexNotifier();
});
