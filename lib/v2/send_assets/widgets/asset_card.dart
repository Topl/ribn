import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/send_asset_provider.dart';
import 'package:ribn/v2/shared/theme.dart';

class AssetCard extends HookConsumerWidget {
  AssetCard({super.key, required this.assetName, required this.assetIcon, required this.assetShortName});

  final String assetName;
  final Widget assetIcon;
  final String assetShortName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(sendAssetProvider.notifier);
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
          // TODO: implement card tap
          notifier.navigateToPage(context);
          print(
            'card tapped - $assetName',
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: assetIcon,
              ),
              Expanded(
                child: Text(
                  assetName,
                  style: bodyMedium(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  assetShortName,
                  style: bodySmall(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
