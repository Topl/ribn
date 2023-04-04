// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/assets.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/v1/widgets/address_display_container.dart';

/// Custom display for the issuer's address.
///
/// Used to display the issuer's address on the [MintInputPage].
class IssuerAddressField extends StatelessWidget {
  const IssuerAddressField({required this.width, Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      informationText: Strings.issuerAddressInfo,
      itemLabel: Strings.issuerAddress,
      item: AddressDisplayContainer(
        text: Strings.yourIssuerAddress,
        icon: RibnAssets.issuerFingerprint,
        width: width,
      ),
    );
  }
}
