// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/address_display_container.dart';
// Package imports:
import 'package:ribn_toolkit/constants/assets.dart';

/// Custom display for the sender's address.
///
/// Used to display the sender's address on the [PolyTransferInputPage].
class FromAddressField extends StatelessWidget {
  const FromAddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAddress>(
      converter: (store) =>
          store.state.keychainState.currentNetwork.addresses.first,
      builder: (context, ribnAddress) => CustomInputField(
        itemLabel: Strings.from,
        item: AddressDisplayContainer(
          // text: Strings.yourRibnWalletAddress,
          text: toShortAddress(ribnAddress.toplAddress.toBase58()),
          icon: RibnAssets.myFingerprint,
          width: 160,
        ),
      ),
    );
  }

  String toShortAddress(String base) {
    if (base.isEmpty)
      throw FormatException("WalletAddress was returned as empty");

    final start = base.substring(0, 4);
    final end = base.substring(base.length - 5);

    return "$start...$end";
  }
}
