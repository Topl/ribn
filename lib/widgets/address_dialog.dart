import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';

/// The dialog that displays the address barcode and text.
class AddressDialog extends StatelessWidget {
  const AddressDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RibnAddress>(
      converter: (store) => store.state.keychainState.currentNetwork.addresses.first,
      builder: (context, ribnAddress) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        titlePadding: EdgeInsets.zero,
        title: Stack(
          children: [
            Positioned(
              top: 18,
              right: 14,
              child: CustomIconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color(0xffb9b9b9),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 40),
                const SizedBox(
                  width: 176,
                  height: 58,
                  child: Text(
                    Strings.myRibnWalletAddress,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: RibnColors.defaultText,
                      height: 1.40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: ribnAddress.toplAddress.toBase58(),
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 16),
                Text(
                  formatAddrString(ribnAddress.toplAddress.toBase58()),
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: RibnColors.defaultText,
                  ),
                ),
                const SizedBox(height: 10),
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        Strings.copyAddress,
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: RibnColors.defaultText,
                        ),
                      ),
                      const SizedBox(width: 5),
                      CustomCopyButton(
                        textToBeCopied: ribnAddress.toplAddress.toBase58(),
                        icon: Image.asset(
                          RibnAssets.copyIcon,
                          width: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
