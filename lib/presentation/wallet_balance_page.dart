import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/utils.dart';

/// Builds the poly balance section and the assets list view.
class WalletBalancePage extends StatelessWidget {
  const WalletBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WalletBalanceContainer(
      builder: (BuildContext context, WalletBalanceViewModel vm) => SingleChildScrollView(
        child: Column(
          children: [
            _buildPolyContainer(vm.polyBalance),
            _buildAssetsListView(),
          ],
        ),
      ),
    );
  }

  /// Builds the top-half container on the balance page.
  /// Displays the balance in Polys and send/receive buttons.
  Widget _buildPolyContainer(num polyBalance) {
    const TextStyle titleTextStyle = TextStyle(
      fontSize: 14.2,
      fontFamily: 'Spectral',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const TextStyle polyBalanceTextStyle = TextStyle(
      fontSize: 26.6,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: Color(0xFF36A190),
    );
    return Container(
      constraints: const BoxConstraints.expand(height: 120),
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

  Widget _buildAssetsListView() {
    return Container(
      color: RibnColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Strings.assets,
              style: RibnTextStyles.h3,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, idx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildAssetListItem(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetListItem() {
    return Container(color: Colors.green, height: 20, child: Text("ASSET"));
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
        return AlertDialog(
          title: Column(
            children: [
              SizedBox(
                height: 10,
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(iconSize: 10, onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close))
                  ],
                ),
              ),
              const Text('Address', style: RibnTextStyles.h2),
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: address,
                width: 130,
                height: 130,
              ),
              Text(formatAddrString(address)),
              const SizedBox(height: 39),
              Container(height: 1, color: Colors.black),
              MaterialButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: address));
                },
                child: const Icon(Icons.copy),
              ),
            ],
          ),
        );
      },
    );
  }
}
