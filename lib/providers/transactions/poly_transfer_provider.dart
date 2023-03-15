// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/models/view/poly_transfer_class.dart';
import 'package:ribn/utils.dart';

final polyTransferProvider = StateNotifierProvider.autoDispose<PolyTransferNotifier, PolyTransferClass>((ref) {
  return PolyTransferNotifier(ref);
});

class PolyTransferNotifier extends StateNotifier<PolyTransferClass> {
  final Ref ref;

  PolyTransferNotifier(this.ref)
      : super(PolyTransferClass(
          amount: 0,
          note: '',
          recipientAddress: '',
          validRecipientAddress: '',
        ));

  // Updates recipient and validates it
  void validateRecipient(String recipient, RibnNetwork network, TextEditingController controller) {
    state = state.copyWith(recipientAddress: recipient);

    validateRecipientAddress(
      networkName: network.networkName,
      address: recipient,
      handleResult: (bool result) {
        if (result) {
          state = state.copyWith(validRecipientAddress: recipient);
          controller.text = '';
        } else {
          state = state.copyWith(validRecipientAddress: '');
        }
      },
    );
  }

  void onRecipientBackspacePressed(TextEditingController controller) {
    final validRecipientAddress = state.validRecipientAddress;

    if (validRecipientAddress.isNotEmpty) {
      controller.text = validRecipientAddress;
      controller
        ..text = controller.text.substring(0, controller.text.length)
        ..selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
    }

    state = state.copyWith(validRecipientAddress: '');
  }

  void updateNote(String note) {
    state = state.copyWith(note: note);
  }

  void updateAmount(String amount) {
    state = state.copyWith(amount: int.parse(amount));
  }
}
