import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';

/// One of the 3 main pages on the home screen.
///
/// Allows the user to initiate the mint transfer flow by selecting between minting to own wallet or to another recipient
class MintPage extends StatelessWidget {
  const MintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 122,
          color: RibnColors.accent,
          child: const Center(
            child: Text(
              Strings.mintAsset,
              style: TextStyle(
                fontFamily: 'Spectral',
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        const SizedBox(
          height: 85,
          child: Text(
            Strings.letsMintANewAsset,
            style: TextStyle(
              color: RibnColors.greyedOut,
              fontFamily: 'Nunito',
              fontSize: 15,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOption(context, myRibnWallet: true),
            const SizedBox(width: 13),
            _buildOption(context, myRibnWallet: false),
          ],
        ),
      ],
    );
  }

  Widget _buildOption(BuildContext context, {required bool myRibnWallet}) {
    final Color backgroundColor = myRibnWallet ? RibnColors.primary : const Color(0xffb1e7e1);
    final Color textColor = myRibnWallet ? Colors.white : RibnColors.primary;
    final String text = myRibnWallet ? Strings.myRibnWallet : Strings.anotherRecipientsWallet;
    final String icon = myRibnWallet ? RibnAssets.myFingerprint : RibnAssets.recipientFingerprint;
    return GestureDetector(
      onTap: () => StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.mintInput)),
      child: Container(
        width: 148,
        height: 135,
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(icon),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: SizedBox(
                width: 100,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
