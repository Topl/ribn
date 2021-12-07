import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/widgets/address_dialog.dart';
import 'package:ribn/widgets/custom_icon_button.dart';

/// One of the 3 main pages on the home screen.
///
/// Displays poly balance section and the assets list view.
class WalletBalancePage extends StatelessWidget {
  const WalletBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalletBalanceContainer(
      builder: (BuildContext context, WalletBalanceViewModel vm) => SingleChildScrollView(
        child: Column(
          children: [
            _buildPolyContainer(vm.polyBalance),
            _buildAssetsListView(vm.assets, vm.initiateSendAsset),
          ],
        ),
      ),
    );
  }

  /// Builds the top-half container on the balance page.
  /// Displays the balance in Polys and send/receive buttons.
  Widget _buildPolyContainer(num polyBalance) {
    const TextStyle titleTextStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Spectral',
      fontWeight: FontWeight.bold,
    );
    const TextStyle polyBalanceTextStyle = TextStyle(
      fontSize: 26.6,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Color(0xFF36A190),
    );
    return Container(
      constraints: const BoxConstraints.expand(height: 122),
      color: RibnColors.accent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Strings.totalAmount, style: titleTextStyle),
              SizedBox(width: 10, child: Image.asset(RibnAssets.infoIcon)),
            ],
          ),
          Text('$polyBalance POLY', style: polyBalanceTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(Strings.send, () {}),
              const SizedBox(width: 10),
              _buildButton(Strings.receive, () async {
                await showReceivingAddress('uihadi3ewfihdsiofhso');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsListView(List<AssetAmount> assets, Function(AssetAmount) initiateSendAsset) {
    return Container(
      color: RibnColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Strings.assets,
              style: TextStyle(
                color: RibnColors.defaultText,
                fontFamily: 'Spectral',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assets.length,
              itemBuilder: (context, idx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildAssetListItem(assets[idx], initiateSendAsset),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetListItem(AssetAmount asset, Function(AssetAmount) initiateSendAsset) {
    const TextStyle titleStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: RibnColors.defaultText,
    );
    const TextStyle shortNameStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      color: Color(0xff585858),
    );
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 73,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 11, right: 16),
            child: SvgPicture.asset(RibnAssets.coffeeGreenIcon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(
                width: 165,
                child: Text(
                  'Long Name',
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Text(asset.assetCode.shortName.show, style: shortNameStyle),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 65,
                child: Text(
                  '${asset.quantity.toString()} Kg',
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle.copyWith(
                    color: RibnColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomIconButton(
                    icon: Image.asset(
                      RibnAssets.sendIcon,
                      width: 12,
                    ),
                    color: RibnColors.primary,
                    onPressed: () => initiateSendAsset(asset),
                  ),
                  const SizedBox(width: 7),
                  CustomIconButton(
                    icon: Image.asset(
                      RibnAssets.receiveIcon,
                      width: 12,
                    ),
                    color: RibnColors.primary,
                    onPressed: () async => await showReceivingAddress('uihadi3ewfihdsiofhso'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    const TextStyle textStyle = TextStyle(
      fontSize: 10.5,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: Color(0xFFFEFEFE),
    );
    return SizedBox(
      width: 75,
      height: 22,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        color: RibnColors.primary,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
              child: Image.asset(
                label == Strings.send ? RibnAssets.sendIcon : RibnAssets.receiveIcon,
              ),
            ),
            const SizedBox(width: 5),
            Text(label, style: textStyle),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }

  Future<void> showReceivingAddress(String address) async {
    await showDialog(
      context: Keys.navigatorKey.currentContext!,
      builder: (context) {
        return const AddressDialog();
      },
    );
  }
}
