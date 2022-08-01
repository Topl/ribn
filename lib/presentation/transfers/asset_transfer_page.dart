import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/asset_transfer_input_container.dart';
import 'package:ribn/containers/poly_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/asset_transfer_section.dart';
import 'package:ribn/presentation/transfers/poly_transfer_section.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/molecules/sliding_segment_control.dart';

/// The asset transfer input page that allows the initiation of an asset transfer.
///
/// Prompts the user to select an asset, the recipient address, amount, and an optional note as transaction metadata.
class AssetTransferPage extends StatefulWidget {
  const AssetTransferPage({Key? key}) : super(key: key);

  @override
  State<AssetTransferPage> createState() => _AssetTransferPageState();
}

class _AssetTransferPageState extends State<AssetTransferPage> {
  int currentTabIndex = 0;

  dynamic bottomButton;

  set setBottomButton(Widget value) => setState(() => bottomButton = value);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        extendBody: true,
        backgroundColor: RibnColors.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // page title
                  const CustomPageTitle(
                    title: Strings.send,
                    hideBackArrow: true,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 310,
                    child: SlidingSegmentControl(
                      currentTabIndex: currentTabIndex,
                      updateTabIndex: (i) => {
                        setState(() {
                          currentTabIndex = i as int;
                        })
                      },
                      tabItems: <int, Widget>{
                        0: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            Strings.sendAssets,
                            style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                          ),
                        ),
                        1: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            Strings.sendNativeCoins,
                            style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.defaultText),
                          ),
                        ),
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  currentTabIndex == 0
                      ? AssetTransferInputContainer(
                          builder: (context, vm) => AssetTransferSection(
                            vm: vm,
                            updateButton: (val) => setState(() => bottomButton = val),
                          ),
                        )
                      : PolyTransferInputContainer(
                          builder: (context, vm) => PolyTransferSection(
                            vm: vm,
                            updateButton: (val) => setState(() => bottomButton = val),
                          ),
                        ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomButton,
      ),
    );
  }
}
