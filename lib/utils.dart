// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:barcode_widget/barcode_widget.dart';
import 'package:brambldart/utils.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';

/// Formats an address string to only dispaly its first and last 10 characters.
String formatAddrString(String addr, {int charsToDisplay = 10}) {
  const numDots = 3;
  final String dotsString = List<String>.filled(numDots, '.').join();
  final String leftSubstring = addr.substring(0, charsToDisplay);
  final String rightSubstring = addr.substring(addr.length - charsToDisplay);
  return '$leftSubstring$dotsString$rightSubstring';
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

/// Formats [unit] to only display the first part of the string.
String formatAssetUnit(String? unit) {
  return unit?.split(' ').first ?? 'Select Unit';
}

/// Validates the [address] passed in by the user.
///
/// Based on the current network, i.e. [networkId], and the [address], [validateAddressByNetwork] validates the address,
/// and [handleResult] is called with the resulting value.
void validateRecipientAddress({
  required String networkName,
  required String address,
  required Function(bool) handleResult,
}) {
  Map<String, dynamic> result = {};
  try {
    result = validateAddressByNetwork(networkName, address);
  } catch (e) {
    result['success'] = false;
  }
  handleResult(result['success']);
}

/// Adapt to screen height based on [scaleFactor].
double adaptHeight(double scaleFactor) =>
    MediaQueryData.fromWindow(window).size.height * scaleFactor;

/// Adapt to screen width based on [scaleFactor].
double adaptWidth(double scaleFactor) =>
    MediaQueryData.fromWindow(window).size.width * scaleFactor;

double deviceTopPadding() => MediaQueryData.fromWindow(window).padding.top;

Future<bool> isAppOpenedInExtensionView() async {
  return await PlatformUtils.instance.getCurrentAppView() == AppViews.extension;
}

Future<bool> isAppOpenedInDebugView() async {
  return await PlatformUtils.instance.getCurrentAppView() == AppViews.webDebug;
}

Uint8List uint8ListFromDynamic(dynamic list) {
  return Uint8List.fromList((list as List).cast<int>());
}

Future<void> showReceivingAddress() async {
  await showDialog(
    context: Keys.navigatorKey.currentContext!,
    builder: (context) {
      return StoreConnector<AppState, RibnAddress>(
        converter: (store) =>
            store.state.keychainState.currentNetwork.addresses.first,
        builder: (context, ribnAddress) {
          return CustomModal.renderCustomModal(
            context: Keys.navigatorKey.currentContext!,
            title: Text(
              Strings.myRibnWalletAddress,
              style: RibnToolkitTextStyles.extH2.copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            body: Column(
              children: [
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
                    fontWeight: FontWeight.w400,
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
          );
        },
      );
    },
  );
}

final emptyStateBody = RichText(
  text: TextSpan(
    style: RibnToolkitTextStyles.h4
        .copyWith(fontSize: kIsWeb ? 12 : 14, color: RibnColors.defaultText),
    children: <TextSpan>[
      TextSpan(
        text: Strings.emptyStateBody.substring(0, 30),
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      TextSpan(text: Strings.emptyStateBody.substring(31, 111)),
    ],
  ),
);
