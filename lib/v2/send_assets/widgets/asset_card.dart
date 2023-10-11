import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/sending_asset_provider.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/theme.dart';

class AssetCard extends HookConsumerWidget {
  AssetCard({super.key, required this.assetName, required this.assetIcon, required this.assetShortName});

  final String assetName;
  final Widget assetIcon;
  final String assetShortName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    final sendAsset = ref.watch(sendingAssetProvider.notifier);
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFFE2E3E3),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: InkWell(
        splashColor: Colors.grey.withAlpha(30),
        onTap: () {
          stepperNotifier.navigateToPage(context);
          sendAsset.setAssetName('${assetName} ${assetShortName}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: assetIcon,
                  ),
                  Text(
                    assetName,
                    style: titleSmall(context),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  assetShortName,
                  style: titleSmall(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
