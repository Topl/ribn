import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';

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
        const CustomPageTitle(
          title: Strings.mintAsset,
          hideBackArrow: true,
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
                fontFamily: 'DM Sans',
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
        return CustomModal.renderCustomModal(
          title: const Text(
            Strings.gettingStarted,
            style: RibnToolkitTextStyles.extH2,
          ),
          context: Keys.navigatorKey.currentContext!,
          body: Column(
            children: [
              SizedBox(
                height: 43,
                child: Text(
                  Strings.mintAssetDesc,
                  style: RibnToolkitTextStyles.hintStyle.copyWith(
                    fontSize: 15,
                    color: RibnColors.greyedOut,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: double.infinity,
                child: Text('Mint to', style: RibnToolkitTextStyles.extH3),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () => StoreProvider.of<AppState>(Keys.navigatorKey.currentContext!).dispatch(
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
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () => StoreProvider.of<AppState>(Keys.navigatorKey.currentContext!).dispatch(
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
