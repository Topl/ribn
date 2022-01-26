import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/widgets/address_display_container.dart';

/// Custom display for the issuer's address.
///
/// Used to display the issuer's address on the [MintInputPage].
class IssuerAddressField extends StatelessWidget {
  const IssuerAddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomInputField(
      informationText: Strings.issuerAddressInfo,
      itemLabel: Strings.issuerAddress,
      item: AddressDisplayContainer(
        text: Strings.yourIssuerAddress,
        icon: RibnAssets.issuerFingerprint,
      ),
    );
  }
}
