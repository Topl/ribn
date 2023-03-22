// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final analyticsInteractionsProvider = Provider<InteractionsTracker>((ref) {
  return InteractionsTracker();
});

class InteractionsTracker {
  List<String> _interactions = [];

  void addInteraction(String interaction) {
    _interactions.add(interaction);
  }
}
