import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/address_display_container.dart';

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
        icon: RibnAssets.issuerFingerprint,
        width: 240,
      ),
    );
  }
}
