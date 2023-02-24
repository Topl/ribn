import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/repositories/misc_repository.dart';

final internalMessageProvider = StateNotifierProvider<InternalMessageNotifier, void>((ref) {
  return InternalMessageNotifier(ref);
});

class InternalMessageNotifier extends StateNotifier<void> {
  final Ref ref;
  InternalMessageNotifier(this.ref) : super(null);

  void sendInternalMessage({
    required InternalMessage message,
  }) {
    MiscRepository miscRepo = MiscRepository();
    miscRepo.sendInternalMessage(message);
  }
}
