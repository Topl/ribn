// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn_toolkit/widgets/atoms/rounded_copy_text_field.dart';

class AddressDisplayContainer extends StatefulWidget {
  const AddressDisplayContainer({
    required this.text,
    required this.icon,
    required this.width,
    Key? key,
  }) : super(key: key);
  final String text;
  final String icon;
  final double width;

  @override
  State<AddressDisplayContainer> createState() =>
      _AddressDisplayContainerState();
}

class _AddressDisplayContainerState extends State<AddressDisplayContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAddress>(
      converter: (store) =>
          store.state.keychainState.currentNetwork.addresses.first,
      builder: (context, ribnAddress) => RoundedCopyTextField(
        text: widget.text,
        icon: SvgPicture.asset(widget.icon),
        copyText: ribnAddress.toplAddress.toBase58(),
        copyIcon: Image.asset(
          RibnAssets.copyIcon,
          width: 26,
        ),
        width: widget.width,
      ),
    );
  }
}
