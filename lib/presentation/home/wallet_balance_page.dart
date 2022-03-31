import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn/presentation/shimmer_loader.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_dialog.dart';
import 'package:ribn/widgets/custom_icon_button.dart';
import 'package:ribn/widgets/custom_tooltip.dart';

/// One of the 3 main pages on the home screen.
///
/// Displays poly balance section and the assets list view.
class WalletBalancePage extends StatefulWidget {
  const WalletBalancePage({Key? key}) : super(key: key);

  @override
  State<WalletBalancePage> createState() => _WalletBalancePageState();
}

class _WalletBalancePageState extends State<WalletBalancePage> {
  /// [TextStyle] for the asset short name.
  final TextStyle assetShortNameStyle = const TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: RibnColors.defaultText,
  );

  /// [TextStyle] for the asset long name.
  final TextStyle assetLongNameStyle = const TextStyle(
    fontFamily: 'Nunito',
    fontSize: 12,
    color: Color(0xff585858),
  );

  /// True if currently fetching balances.
  bool _fetchingBalances = true;

  /// True if ribn failed to fetch balances.
  bool _failedToFetchBalances = false;

  final String tooltipUrl = 'https://topl.services';
  final double tooltipIconWidth = 10;

  /// Refreshes balances on the current network.
  ///
  /// Updates [_fetchingBalances] and [_failedToFetchBalances] to indicate that balances are being fetched.
  void refreshBalances(WalletBalanceViewModel vm) {
    setState(() {
      _fetchingBalances = true;
      _failedToFetchBalances = false;
    });
    vm.refreshBalances(onBalancesRefreshed: onBalancesRefreshed);
  }

  /// Updates [_fetchingBalances] and [_failedToFetchBalances] to indicate that balances have been fetched.
  void onBalancesRefreshed(bool success) {
    setState(() {
      _fetchingBalances = false;
      _failedToFetchBalances = !success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WalletBalanceContainer(
      // refresh balances on initial build
      onInitialBuild: refreshBalances,
      onWillChange: (prevVm, currVm) {
        // refresh balances on network toggle
        if (prevVm?.currentNetwork.networkName != currVm.currentNetwork.networkName ||
            prevVm?.currentNetwork.lastCheckedTimestamp != currVm.currentNetwork.lastCheckedTimestamp ||
            prevVm?.currentNetwork.addresses.length != currVm.currentNetwork.addresses.length) {
          refreshBalances(currVm);
        }
      },
      builder: (BuildContext context, WalletBalanceViewModel vm) => SingleChildScrollView(
        child: _failedToFetchBalances
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ErrorSection(
                    onTryAgain: () => refreshBalances(vm),
                  ),
                ),
              )
            : Column(
                children: _fetchingBalances
                    ? [ShimmerLoader()]
                    : [
                        _buildPolyContainer(vm),
                        _buildAssetsListView(vm),
                      ],
              ),
      ),
    );
  }

  /// Builds the top-half container on the balance page.
  /// Displays the balance in Polys and send/receive buttons.
  Widget _buildPolyContainer(WalletBalanceViewModel vm) {
    const TextStyle polyBalanceTextStyle = TextStyle(
      fontSize: 26.6,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Color(0xFF36A190),
    );

    CustomToolTip renderTooltip() {
      if (vm.polyBalance > 0) {
        return CustomToolTip(
          tooltipText: Strings.refillCurrentPolyBalance,
          offsetPositionLeftValue: 190,
          tooltipIcon: SvgPicture.asset(
            RibnAssets.roundInfoCircle,
            width: tooltipIconWidth,
          ),
          tooltipUrlText: 'BaaS.',
          tooltipUrl: tooltipUrl,
          toolTipBackgroundColor: const Color(0xffeef9f8),
        );
      } else {
        return CustomToolTip(
          tooltipText: Strings.refillEmptyPolyBalance,
          offsetPositionLeftValue: 140,
          tooltipIcon: SvgPicture.asset(
            RibnAssets.smsFailed,
            width: tooltipIconWidth,
          ),
          tooltipUrlText: 'BaaS.',
          tooltipUrl: tooltipUrl,
          toolTipBackgroundColor: const Color(0xffeef9f8),
        );
      }
    }

    return Container(
      constraints: const BoxConstraints.expand(height: 122),
      color: RibnColors.accent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Strings.totalAmount, style: RibnTextStyles.extH3),
              SizedBox(
                width: 10,
                child: renderTooltip(),
              ),
            ],
          ),
          _fetchingBalances
              ? const CircularProgressIndicator()
              : _failedToFetchBalances
                  ? const Text('Network Failure', style: TextStyle(color: Colors.red))
                  : Text('${vm.polyBalance} POLY', style: polyBalanceTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(Strings.send, vm.navigateToSendPolys),
              const SizedBox(width: 10),
              _buildButton(Strings.receive, () async {
                await showReceivingAddress();
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a [ListView] of the assets owned by the wallet.
  ///
  /// The ViewModel [vm] allows access to the list of assets, asset details, and callbacks.
  Widget _buildAssetsListView(WalletBalanceViewModel vm) {
    return Container(
      color: RibnColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Strings.assets,
              style: RibnTextStyles.extH3,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.assets.length,
              itemBuilder: (context, idx) {
                final AssetAmount asset = vm.assets[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildAssetListItem(
                    asset: asset,
                    assetDetails: vm.assetDetails[asset.assetCode.toString()],
                    initiateSendAsset: vm.navigateToSendAsset,
                    viewAssetDetails: vm.viewAssetDetails,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the individual asset list item.
  ///
  /// Displays information about the [asset], including locally stored details, i.e. [assetDetails].
  /// More information about the asset can be viewed upon pressing and calling [viewAssetDetails].
  /// Upon pressing the send button, an asset transfer flow can be initiated, i.e. [initiateSendAsset].
  Widget _buildAssetListItem({
    required AssetAmount asset,
    required AssetDetails? assetDetails,
    required Function(AssetAmount) initiateSendAsset,
    required Function(AssetAmount) viewAssetDetails,
  }) {
    final String assetIcon = assetDetails?.icon ?? RibnAssets.undefinedIcon;
    final String assetUnit = assetDetails?.unit != null ? formatAssetUnit(assetDetails!.unit) : 'Units';
    final String assetLongName = assetDetails?.longName ?? '';
    final bool isMissingAssetDetails =
        assetIcon == RibnAssets.undefinedIcon || assetUnit == 'Units' || assetLongName.isEmpty;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(RibnColors.whiteBackground),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: MaterialStateProperty.all(const Size(309, 88)),
      ),
      onPressed: () => viewAssetDetails(asset),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // display asset icon
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 11, right: 16),
            child: Image.asset(assetIcon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // display asset short name
              SizedBox(
                width: 120,
                child: Text(
                  asset.assetCode.shortName.show,
                  style: assetShortNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // display asset long name or placeholder if no long name exists
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: assetLongName.isNotEmpty
                    ? Text(assetLongName, style: assetLongNameStyle)
                    : Container(
                        width: 139,
                        height: 13,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          color: Color(0xcfdadada),
                        ),
                      ),
              ),
              // display helpful text if some asset details are missing
              isMissingAssetDetails
                  ? const Text(
                      'Add Asset Details',
                      style: TextStyle(
                        color: RibnColors.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                        fontStyle: FontStyle.normal,
                        fontSize: 10.4,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // display asset units
              Container(
                constraints: const BoxConstraints(maxWidth: 90),
                child: Text(
                  '${asset.quantity.toString()} $assetUnit',
                  overflow: TextOverflow.ellipsis,
                  style: assetShortNameStyle.copyWith(
                    color: RibnColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // send and receive buttons
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
                    onPressed: () async => await showReceivingAddress(),
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

  Future<void> showReceivingAddress() async {
    await showDialog(
      context: Keys.navigatorKey.currentContext!,
      builder: (context) {
        return const AddressDialog();
      },
    );
  }
}
