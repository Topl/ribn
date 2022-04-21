import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn/presentation/home/shimmer_loader.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/address_dialog.dart';
import 'package:ribn/widgets/custom_tooltip.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_card.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// BaaS redirect url for refilling Poly balance.
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
          if (currVm.currentNetwork.addresses.isNotEmpty) refreshBalances(currVm);
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
      final bool hasPolys = vm.polyBalance > 0;
      return CustomToolTip(
        toolTipIcon: hasPolys ? Image.asset(RibnAssets.roundInfoCircle) : Image.asset(RibnAssets.smsFailed),
        toolTipChild: RichText(
          text: TextSpan(
            style: RibnToolkitTextStyles.toolTipTextStyle,
            children: [
              TextSpan(
                text: hasPolys ? Strings.refillCurrentPolyBalance : Strings.refillEmptyPolyBalance,
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () async => await launch(tooltipUrl),
                  child: Row(
                    children: [
                      Text(
                        ' Baas. ',
                        style: RibnToolkitTextStyles.toolTipTextStyle.copyWith(
                          color: const Color(0xff00B5AB),
                        ),
                      ),
                      Image.asset(
                        RibnAssets.openInNewWindow,
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
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
              const Text(Strings.totalAmount, style: RibnToolkitTextStyles.extH3),
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
              style: RibnToolkitTextStyles.extH3,
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

    return AssetCard(
      onCardPress: () => viewAssetDetails(asset),
      iconImage: Image.asset(assetIcon),
      shortName: Text(
        asset.assetCode.shortName.show,
        style: assetShortNameStyle,
        overflow: TextOverflow.ellipsis,
      ),
      assetLongName: assetLongName.isNotEmpty
          ? Text(assetLongName, style: assetLongNameStyle)
          : Container(
              width: 139,
              height: 13,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: Color(0xcfdadada),
              ),
            ),
      missingAsstDetailsCondition: isMissingAssetDetails,
      assetQuantityDetails: Text(
        '${asset.quantity.toString()} $assetUnit',
        overflow: TextOverflow.ellipsis,
        style: assetShortNameStyle.copyWith(
          color: RibnColors.primary,
        ),
      ),
      firstIcon: Image.asset(
        RibnAssets.sendIcon,
        width: 12,
      ),
      onFirstIconPress: () => initiateSendAsset(asset),
      secondIcon: Image.asset(
        RibnAssets.receiveIcon,
        width: 12,
      ),
      onSecondIconPress: () async => await showReceivingAddress(),
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
      child: LargeButton(
        backgroundColor: RibnColors.primary,
        onPressed: onPressed,
        buttonChild: Row(
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
