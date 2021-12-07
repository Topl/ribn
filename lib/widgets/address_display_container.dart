import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/colors.dart';

/// A custom container that displays addresses.
class AddressDisplayContainer extends StatelessWidget {
  const AddressDisplayContainer({
    this.backgroundColor = RibnColors.whiteBackground,
    required this.text,
    required this.asset,
    this.canCopy = false,
    Key? key,
  }) : super(key: key);
  final Color backgroundColor;
  final String text;
  final String asset;
  final bool canCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 193,
      height: 23,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 7),
            child: SizedBox(width: 19, height: 19, child: SvgPicture.asset(asset)),
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: RibnColors.defaultText,
            ),
          ),
        ],
      ),
    );
  }
}
