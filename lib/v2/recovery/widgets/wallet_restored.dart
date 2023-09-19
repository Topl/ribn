import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v2/onboarding/screens/app_introduction.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:vrouter/vrouter.dart';

import '../../shared/constants/assets.dart';

class WalletAccessRestored extends ConsumerWidget {
  const WalletAccessRestored({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.walletAccess),
                SizedBox(height: 16),
                Text(
                  Strings.walletAccessRestored,
                  style: headlineLarge(context),
                ),
                SizedBox(height: 16),
                Text(
                  Strings.walletAccessRestoredDesc,
                  style: bodyMedium(context),
                ),
                SizedBox(height: 16),
                Text(
                  Strings.keepSafeAndProtectAssets,
                  style: labelMedium(context),
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.vRouter.to(AppTutorialScreen().route);
              },
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
