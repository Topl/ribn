// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/assets.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/ribn_address.dart';
import 'package:ribn/v1/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/v1/widgets/address_display_container.dart';

/// Custom display for the sender's address.
///
/// Used to display the sender's address on the [PolyTransferInputPage].
class FromAddressField extends StatelessWidget {
  const FromAddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAddress>(
      converter: (store) => store.state.keychainState.currentNetwork.addresses.first,
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
    if (base.isEmpty) throw FormatException("WalletAddress was returned as empty");

    final start = base.substring(0, 4);
    final end = base.substring(base.length - 5);

    return "$start...$end";
  }
}
