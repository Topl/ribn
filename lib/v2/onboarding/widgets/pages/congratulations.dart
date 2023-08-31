import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:vrouter/vrouter.dart';

import '../../../shared/constants/assets.dart';

class CongratulationSeedPhrase extends ScreenWidget {
  const CongratulationSeedPhrase({super.key}) : super(route: '/seed-congratulation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
                      Strings.createRibnWallet,
                      style: headlineLarge(context),
                    ),
                    SizedBox(height: 16),
                    Text(
                      Strings.createRibnWalletSub,
                      style: bodyMedium(context),
                    ),
                    SizedBox(height: 16),
                    Text(
                      Strings.keepWalletSecure,
                      style: bodyMedium(context),
                    ),
                    SizedBox(height: 200),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.vRouter.to(AssetManagementScreen().route);
                  },
                  child: Text(
                    Strings.goToWallet,
                    style: labelLarge(context),
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
        ),
      ),
    );
  }
}
