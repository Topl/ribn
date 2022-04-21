import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/custom_close_button.dart';

/// One of the 3 main pages on the home screen.
///
/// Allows the user to initiate the mint transfer flow by selecting between
/// 1. 'mint a new asset' and 'remint same asset', and
/// 2. 'mint to my wallet' and 'mint to another wallet'.
class MintPage extends StatelessWidget {
  const MintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // page title
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
        // page description
        const Center(
          child: SizedBox(
            width: 250,
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
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(Strings.whatWouldYouLikeToDo, style: RibnToolkitTextStyles.extH3),
              ),
              const SizedBox(height: 20),
              // buttons to choose between 'mint new asset' and 'remint same asset'
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMintOption(context, mintingNewAsset: true),
                  const SizedBox(width: 13),
                  _buildMintOption(context, mintingNewAsset: false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the mint option buttons.
  ///
  /// Depending on [mintingNewAsset]'s value,
  /// either [RibnAssets.mintNewAssetButton] or [RibnAssets.remintSameAssetButton] is displayed.
  Widget _buildMintOption(
    BuildContext context, {
    required bool mintingNewAsset,
  }) {
    final String icon = mintingNewAsset ? RibnAssets.mintNewAssetButton : RibnAssets.remintSameAssetButton;
    return MaterialButton(
      onPressed: () async => await _buildMintDialog(mintingNewAsset),
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(icon),
    );
  }

  /// Builds a dialog with buttons to
  /// allow the user to choose between 'mint to my own wallet' and 'mint to another wallet'.
  Future<void> _buildMintDialog(bool mintingNewAsset) async {
    await showDialog(
      context: Keys.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 100),
          backgroundColor: RibnColors.accent,
          titlePadding: EdgeInsets.zero,
          title: Stack(
            children: [
              // top-right close button
              const Positioned(
                top: 18,
                right: 14,
                child: CustomCloseButton(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // dialog title
                    const SizedBox(
                      width: 176,
                      height: 58,
                      child: Text(
                        Strings.gettingStarted,
                        style: RibnToolkitTextStyles.extH2,
                      ),
                    ),
                    // dialog description
                    SizedBox(
                      width: 245,
                      height: 43,
                      child: Text(
                        Strings.mintAssetDesc,
                        style: RibnToolkitTextStyles.hintStyle.copyWith(
                          fontSize: 15,
                          color: RibnColors.greyedOut,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text('Mint to', style: RibnToolkitTextStyles.extH3),
                    ),
                    const SizedBox(height: 15),
                    // buttons to choose between 'mint to my wallet' and 'mint to another wallet'
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                            NavigateToRoute(
                              Routes.mintInput,
                              arguments: {
                                'mintingNewAsset': mintingNewAsset,
                                'mintingToMyWallet': true,
                              },
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(RibnAssets.myWalletButton),
                        ),
                        const SizedBox(width: 12.7),
                        MaterialButton(
                          onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                            NavigateToRoute(
                              Routes.mintInput,
                              arguments: {
                                'mintingNewAsset': mintingNewAsset,
                                'mintingToMyWallet': false,
                              },
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(RibnAssets.anotherWalletButton),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
