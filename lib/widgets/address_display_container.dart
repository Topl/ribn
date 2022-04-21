import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/widgets/custom_copy_button.dart';

class AddressDisplayContainer extends StatefulWidget {
  const AddressDisplayContainer({
    this.backgroundColor = RibnColors.whiteBackground,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final String text;
  final String icon;

  @override
  State<AddressDisplayContainer> createState() => _AddressDisplayContainerState();
}

class _AddressDisplayContainerState extends State<AddressDisplayContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAddress>(
      converter: (store) => store.state.keychainState.currentNetwork.addresses.first,
      builder: (context, ribnAddress) => Container(
        width: 193,
        height: 23,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 7),
              child: SizedBox(width: 19, height: 19, child: SvgPicture.asset(widget.icon)),
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: RibnColors.defaultText,
              ),
            ),
            const Spacer(),
            CustomCopyButton(textToBeCopied: ribnAddress.toplAddress.toBase58()),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
