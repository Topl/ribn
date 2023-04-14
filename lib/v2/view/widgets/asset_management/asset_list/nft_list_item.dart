import 'package:flutter/material.dart';
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';

class NFTListItem extends StatelessWidget {
  final String assetName;
  final String assetUrl;
  const NFTListItem({
    required this.assetName,
    required this.assetUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _Icon(
            assetUrl: assetUrl,
          ),
          SizedBox(width: 10),
          Text(
            assetName,
            style: RibnTextStyle.h3,
          ),
          Spacer(),
          Text(
            "1",
            style: RibnTextStyle.h3,
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final String assetUrl;
  const _Icon({
    required this.assetUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: RibnColors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Image.asset(assetUrl),
      ),
    );
  }
}
