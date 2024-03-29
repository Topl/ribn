// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';

// Project imports:
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/asset_details.dart';
import 'package:ribn/v1/presentation/asset_details/asset_detail_items/asset_amount_details.dart';
import 'package:ribn/v1/presentation/asset_details/asset_detail_items/asset_code_details.dart';
import 'package:ribn/v1/presentation/asset_details/asset_detail_items/asset_code_short_details.dart';
import 'package:ribn/v1/presentation/asset_details/asset_detail_items/token_metadata_details.dart';
import 'package:ribn/v1/widgets/custom_divider.dart';
import 'asset_detail_items/issuer_address_details.dart';

/// This page presents all details associated with an asset.
///
/// Also allows editing certain properties that are stored locally,
/// such as the asset long name, asset unit, and asset icon.
class AssetDetailsPage extends StatefulWidget {
  /// The [AssetAmount] for which details are presented on this screen.
  final AssetAmount asset;

  /// The asset code of this [asset].
  final String assetCode;

  /// The asset short name of this [asset] (also refered to as asset code short).
  final String assetShortName;

  /// The quantity of this [asset] that the user has in their wallet.
  final num assetQuantity;

  /// The issuer address for this [asset].
  final String issuerAddress;

  AssetDetailsPage({
    Key? key,
    required this.asset,
  })  : assetCode = asset.assetCode.toString(),
        assetShortName = asset.assetCode.shortName.show,
        assetQuantity = asset.quantity,
        issuerAddress = asset.assetCode.issuer.toBase58(),
        super(key: key);

  @override
  _AssetDetailsPageState createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage> with RouteAware {
  /// GlobalKeys are initialized for modifiable detail items on this page.
  ///
  /// Primarily used to identify and locate the positon of the respective widgets, in order to correctly insert [editSectionOverlay].
  final GlobalKey assetUnitKey = GlobalKey();
  final GlobalKey assetLongNameKey = GlobalKey();
  final GlobalKey assetIconKey = GlobalKey();

  /// An [OverlayEntry] initialized with a placeholder widget.
  ///
  /// When the user wants to edit an item on the page, [editSectionOverlay] is assigned the appropriate widget and displayed
  /// on the page. See [_buildEditSectionOverlay].
  OverlayEntry editSectionOverlay = OverlayEntry(builder: (context) => const SizedBox());

  /// True if the asset unit section is being edited.
  bool editingAssetUnit = false;

  /// True if the asset long name section is being edited.
  bool editingAssetLongName = false;

  /// True if the asset icon section is being edited.
  bool editingAssetIcon = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to changes in routes.
    Routes.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    super.dispose();
    // Unmount any overlays present and unsubscribe from route changes.
    if (editSectionOverlay.mounted) editSectionOverlay.remove();
    Routes.routeObserver.unsubscribe(this);
  }

  @override
  void didPushNext() {
    // Reset overlays when a new route is pushed.
    resetOverlays(resetAll: true);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AssetDetails?>(
      // Get access to AssetDetails for this asset from the store
      converter: (store) => store.state.userDetailsState.assetDetails[widget.assetCode],
      builder: (context, assetDetails) {
        print(assetDetails);
        return Listener(
          onPointerDown: (_) {
            if (mounted) setState(() {});
            resetOverlays(resetAll: true);
          },
          child: Scaffold(
            backgroundColor: RibnColors.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomPageTextTitle(
                    title: Strings.assetDetails,
                    hideBackArrow: true,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(11.6)),
                        color: RibnColors.whiteBackground,
                        border: Border.all(color: RibnColors.lightGrey, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: RibnColors.greyShadow,
                            spreadRadius: 0,
                            blurRadius: 37.5,
                            offset: Offset(0, -6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // asset name display
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: AssetCodeShortDetails(
                                  assetShortName: widget.assetShortName,
                                  currentIcon: assetDetails?.icon,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: AssetAmountDetails(assetQuantity: widget.assetQuantity),
                              ),
                            ],
                          ),
                          _buildDivider(),
                          // asset issuer address display
                          IssuerAddressDetails(
                            issuerAddress: widget.issuerAddress,
                          ),
                          _buildDivider(),
                          // asset code display
                          AssetCodeDetails(assetCode: widget.assetCode),
                          _buildDivider(),
                          //TODO: Figure out how to pipe metadata in
                          TokenMetadataDetails(
                            tokenMetadata: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the edit section overlay.
  ///
  /// Uses the [key] provided to get the correct widget position and
  /// updates [editSectionOverlay] with the [editSection] provided.
  // void _buildEditSectionOverlay({
  //   required GlobalKey key,
  //   required Widget editSection,
  // }) async {
  //   final RenderBox renderbox =
  //       key.currentContext!.findRenderObject() as RenderBox;
  //   final Offset offset = renderbox.localToGlobal(Offset.zero);
  //   resetOverlays();
  //   editSectionOverlay = OverlayEntry(
  //     builder: (context) {
  //       return Positioned(
  //         left: offset.dx - 20,
  //         top: offset.dy + 22,
  //         child: editSection,
  //       );
  //     },
  //   );
  //   Overlay.of(context)!.insert(editSectionOverlay);
  // }

  /// Removes any overlay from the screen and resets
  /// indicators for editing.
  void resetOverlays({bool resetAll = false}) {
    if (mounted && resetAll) {
      setState(() {
        editingAssetUnit = false;
        editingAssetIcon = false;
        editingAssetLongName = false;
      });
    }
    if (editSectionOverlay.mounted) editSectionOverlay.remove();
  }

  /// Handler for when edit button is pressed for one of the asset detail items.
  ///
  /// Depending on the [key] passed, the state is updated and
  /// [_buildEditSectionOverlay] is called with the appropriate [editSection] widget.
  // void _onEditPressed({required Key key, required AssetDetails? assetDetails}) {
  //   if (key == assetUnitKey) {
  //     setState(() {
  //       editingAssetUnit = true;
  //     });
  //     _buildEditSectionOverlay(
  //       key: assetUnitKey,
  //       editSection: AssetUnitEditSection(
  //         assetCode: widget.assetCode,
  //         currentUnit: assetDetails?.unit,
  //         onActionTaken: () => resetOverlays(resetAll: true),
  //       ),
  //     );
  //   } else if (key == assetLongNameKey) {
  //     setState(() {
  //       editingAssetLongName = true;
  //     });
  //     _buildEditSectionOverlay(
  //       key: assetLongNameKey,
  //       editSection: AssetLongNameEditSection(
  //         assetCode: widget.assetCode,
  //         currentAssetLongName: assetDetails?.longName,
  //         onActionTaken: () => resetOverlays(resetAll: true),
  //       ),
  //     );
  //   } else {
  //     setState(() {
  //       editingAssetIcon = true;
  //     });
  //     _buildEditSectionOverlay(
  //       key: assetIconKey,
  //       editSection: AssetIconEditSection(
  //         assetCode: widget.assetCode,
  //         onActionTaken: () => resetOverlays(resetAll: true),
  //       ),
  //     );
  //   }
  // }

  /// Builds a divider that is used to separate asset detail items on screen.
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
      child: CustomDivider(),
    );
  }
}
