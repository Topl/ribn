import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/wallet_balance_container.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/presentation/empty_state_screen.dart';
import 'package:ribn/presentation/error_section.dart';
import 'package:ribn/presentation/home/wallet_balance_shimmer.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_card.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';
// import 'package:url_launcher/url_launcher.dart';

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
    Future.delayed((const Duration(seconds: 1))).then((_) {
      setState(() {
        _fetchingBalances = false;
        _failedToFetchBalances = !success;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WalletBalanceContainer(
      // refresh balances on initial build
      onInitialBuild: refreshBalances,
      onWillChange: (prevVm, currVm) {
        // refresh balances on network toggle or when new addresses are generated
        final bool shouldRefresh = currVm.walletExists &&
            (prevVm?.currentNetwork.networkName != currVm.currentNetwork.networkName ||
                prevVm?.currentNetwork.lastCheckedTimestamp !=
                    currVm.currentNetwork.lastCheckedTimestamp ||
                prevVm?.currentNetwork.addresses.length != currVm.currentNetwork.addresses.length);
        if (shouldRefresh) refreshBalances(currVm);
      },
      builder: (BuildContext context, WalletBalanceViewModel vm) => _failedToFetchBalances
          ? Center(
              child: ErrorSection(
                onTryAgain: () => refreshBalances(vm),
              ),
            )
          : RefreshIndicator(
              backgroundColor: RibnColors.primary,
              color: RibnColors.secondaryDark,
              onRefresh: () async {
                return refreshBalances(vm);
              },
              child: SingleChildScrollView(
                child: Listener(
                  onPointerDown: (_) {
                    if (mounted) setState(() {});
                  },
                  child: Column(
                    children: _fetchingBalances
                        ? [const WalletBalanceShimmer()]
                        : [
                            _buildPolyContainer(vm),
                            _buildAssetsListView(vm),
                          ],
                  ),
                ),
              ),
            ),
    );
  }

  /// Builds the top-half container on the balance page.
  /// Displays the balance in Polys and send/receive buttons.
  Widget _buildPolyContainer(WalletBalanceViewModel vm) {
    // final Uri url = Uri.parse(tooltipUrl);

    CustomToolTip renderTooltip() {
      final bool hasPolys = vm.polyBalance > 0;
      return CustomToolTip(
        borderColor: Border.all(color: const Color(0xffE9E9E9)),
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
                  // onTap: () async => await launchUrl(url),
                  // Temporary add redirect to DApp flow
                  onTap: () => Keys.navigatorKey.currentState?.pushNamed(
                    Routes.loadingDApp,
                  ),
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
              'Available balance',
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
    if (vm.assets.isEmpty) {
      return EmptyStateScreen(
        icon: RibnAssets.walletWithBorder,
        title: Strings.noAssetsInWallet,
        body: emptyStateBody,
        buttonOneText: 'Mint',
        buttonOneAction: () => Keys.navigatorKey.currentState?.pushNamed(
          Routes.mintInput,
          arguments: {
            'mintingNewAsset': true,
            'mintingToMyWallet': true,
          },
        ),
        buttonTwoText: 'Share',
        buttonTwoAction: () async => await showReceivingAddress(),
        mobileHeight: MediaQuery.of(context).size.height * 0.5,
        desktopHeight: 258,
      );
    }

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
                // Here's how we get each individual asset
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

    final String assetUnit =
        assetDetails?.unit != null ? formatAssetUnit(assetDetails!.unit) : 'Unit';
    final String assetLongName = assetDetails?.longName ?? '';
    final bool isMissingAssetDetails =
        assetIcon == RibnAssets.undefinedIcon || assetUnit == 'Unit' || assetLongName.isEmpty;

    bool isNft = false;
    return AssetCard(
      isNft: isNft,
      onCardPress: () => viewAssetDetails(asset),
      iconImage: Image.asset(
        assetIcon,
        width: 300,
      ),
      shortName: Text(
        asset.assetCode.shortName.show.replaceAll('\x00', ''),
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
        isNft ? '${asset.quantity.toString()}' : '${asset.quantity.toString()} $assetUnit',
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
}
