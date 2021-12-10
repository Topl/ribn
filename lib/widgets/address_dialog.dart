import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_icon_button.dart';

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
        titlePadding: EdgeInsets.zero,
        title: Stack(
          children: [
            Positioned(
              top: 18,
              right: 14,
              child: CustomIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Color(0xffb9b9b9),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 40),
                const SizedBox(
                  width: 176,
                  height: 58,
                  child: Text(
                    'My Ribn Wallet Address',
                    style: TextStyle(
                      fontFamily: 'Spectral',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: RibnColors.defaultText,
                      height: 1.40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: ribnAddress.address.toBase58(),
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 16),
                Text(
                  formatAddrString(ribnAddress.address.toBase58()),
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: RibnColors.defaultText,
                  ),
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: const Color(0xffe9e9e9)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Copy address',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: RibnColors.defaultText,
                        ),
                      ),
                      const SizedBox(width: 5),
                      CustomIconButton(
                        color: const Color(0xfff9f9f9),
                        icon: SvgPicture.asset(RibnAssets.contentCopyIcon),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: ribnAddress.address.toBase58()));
                        },
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
