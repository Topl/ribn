// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:ribn/constants/strings.dart';
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
    return const CustomInputField(
      itemLabel: Strings.from,
      item: AddressDisplayContainer(
        text: Strings.yourRibnWalletAddress,
        icon: RibnAssets.myFingerprint,
        width: 240,
      ),
    );
  }
}
