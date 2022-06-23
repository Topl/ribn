import 'package:barcode_widget/barcode_widget.dart';
import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn/presentation/home/wallet_balance_shimmer.dart';
import 'package:ribn/utils.dart';
import 'package:ribn/widgets/custom_divider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_card.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_modal.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';
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
        child: Listener(
          onPointerDown: (_) {
            if (mounted) setState(() {});
          },
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
                      ? [const WalletBalanceShimmer()]
                      : [
                          _buildPolyContainer(vm),
                          _buildAssetsListView(vm),
                        ],
                ),
        ),
      ),
    );
  }

  /// Builds the top-half container on the balance page.
  /// Displays the balance in Polys and send/receive buttons.
  Widget _buildPolyContainer(WalletBalanceViewModel vm) {
    CustomToolTip renderTooltip() {
      final bool hasPolys = vm.polyBalance > 0;
      return CustomToolTip(
        offsetPositionLeftValue: 180,
        toolTipIcon: Image.asset(
          RibnAssets.circleInfo,
          width: 24,
        ),
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

    return WaveContainer(
      containerHeight: 183,
      containerWidth: double.infinity,
      waveAmplitude: 0,
      containerChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _fetchingBalances
              ? const CircularProgressIndicator()
              : _failedToFetchBalances
                  ? const Text('Network Failure', style: TextStyle(color: Colors.red))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${vm.polyBalance} POLY',
                          style: RibnToolkitTextStyles.h2.copyWith(
                            color: const Color(0xFFE5E5E5),
                            letterSpacing: 1.42,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: SizedBox(
                            width: 24,
                            child: renderTooltip(),
                          ),
                        ),
                      ],
                    ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '\$${vm.polyBalance}',
              style: RibnToolkitTextStyles.h3.copyWith(
                color: RibnColors.secondaryDark,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(Strings.send, vm.navigateToSendAssets),
              const SizedBox(width: 10),
              _buildButton(
                Strings.receive,
                () async => await showReceivingAddress(),
              ),
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
        padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                Strings.assets,
                style: RibnToolkitTextStyles.extH3,
              ),
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
    required Function(AssetAmount) viewAssetDetails,
  }) {
    final String assetIcon = assetDetails?.icon ?? RibnAssets.undefinedIcon;
    final String assetUnit = assetDetails?.unit != null ? formatAssetUnit(assetDetails!.unit) : 'Unit';
    final String assetLongName = assetDetails?.longName ?? '';
    final bool isMissingAssetDetails =
        assetIcon == RibnAssets.undefinedIcon || assetUnit == 'Unit' || assetLongName.isEmpty;

    return AssetCard(
      onCardPress: () => viewAssetDetails(asset),
      iconImage: Image.asset(assetIcon, width: 31),
      shortName: Text(
        asset.assetCode.shortName.show,
        style: RibnToolkitTextStyles.assetShortNameStyle,
        overflow: TextOverflow.ellipsis,
      ),
      assetLongName: assetLongName.isNotEmpty
          ? Text(assetLongName, style: RibnToolkitTextStyles.assetLongNameStyle)
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
        style: RibnToolkitTextStyles.assetShortNameStyle.copyWith(
          color: RibnColors.primary,
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 135,
      height: 35,
      child: LargeButton(
        buttonWidth: 135,
        buttonHeight: 35,
        backgroundColor: RibnColors.primary,
        dropShadowColor: RibnColors.whiteButtonShadow,
        onPressed: onPressed,
        buttonChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: RibnToolkitTextStyles.h4.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Future<void> showReceivingAddress() async {
    await showDialog(
      context: Keys.navigatorKey.currentContext!,
      builder: (context) {
        return StoreConnector<AppState, RibnAddress>(
          converter: (store) => store.state.keychainState.currentNetwork.addresses.first,
          builder: (context, ribnAddress) {
            return CustomModal.renderCustomModal(
              context: Keys.navigatorKey.currentContext!,
              title: const Text(
                Strings.myRibnWalletAddress,
                style: RibnToolkitTextStyles.extH2,
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
            );
          },
        );
      },
    );
  }
}
