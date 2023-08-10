import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/v2/shared/theme.dart';

import '../../../shared/constants/assets.dart';

class CongratulationSeedPhrase extends StatelessWidget {
  const CongratulationSeedPhrase({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.walletWithOutline),
                SizedBox(height: 16),
                Text(
                  "Congrats on creating your Ribn wallet!",
                  style: headlineLarge(context),
                ),
                SizedBox(height: 16),
                Text(
                  "You can now securely store, manage, and interact with your digital assets and DApps in the Topl ecosystem.",
                  style: bodyMedium(context),
                ),
                SizedBox(height: 16),
                Text(
                  "Keep your wallet secure to protect your assets.",
                  style: bodyMedium(context),
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Go to Wallet',
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
        ],
      ),
    );
  }
}
