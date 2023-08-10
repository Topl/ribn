import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../shared/theme.dart';

class ReceiveAssetsAddressScreen extends StatelessWidget {
  const ReceiveAssetsAddressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Receive",
            style: headlineLarge(context),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Share your single use address",
                  style: bodyMedium(context),
                ),
              ),
              Tooltip(
                message: 'Learn more about single use addresses',
                preferBelow: false,
                child: Icon(
                  Icons.info_outline,
                  color: Color(0xFFC0C4C4),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          SearchBar(
            leading: SvgPicture.asset('assets/v2/icons/search_logo.svg'),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            constraints: BoxConstraints(
              minHeight: 40,
            ),
            hintText: "Search",
            hintStyle: MaterialStateProperty.all(
              labelLarge(context),
            ),
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Color(0xFFE2E3E3),
                ),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            onChanged: (value) {
              //TODO: implement search
              print(value);
            },
          ),
          SizedBox(height: 20),
          Center(
            child: QrImageView(
              // address of the user
              data: '0q1We2rTy34a5SD6fZX70q1We2rTy34a5SD6fZX70q',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF0DC8D4).withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '0q1We2rTy34a5SD6fZX70q1We2rTy34a5SD6fZX70q',
                    style: bodyMedium(context),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: "0q1We2rTy34a5SD6fZX70q1We2rTy34a5SD6fZX70q"));
                  },
                  icon: Icon(
                    Icons.content_copy,
                    color: Color(0xFF0DC8D4),
                    size: 24,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF7040EC).withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFF7040EC),
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Please send only Topl Transaction (LVL) to this address. Sending any other tokens may be permanent lost.',
                    style: TextStyle(
                        fontSize: 14, color: Color(0xFF7040EC), fontFamily: 'Rational Display', height: 20 / 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Share Address',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Rational Display',
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0DC8D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
