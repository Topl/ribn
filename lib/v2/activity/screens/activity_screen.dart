// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/activity/widgets/activity_transaction.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/asset_managment/providers/loaded_assets_provider.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:vrouter/vrouter.dart';

class ActivityScreen extends ScreenConsumerWidget {
  static const Key assetManagementScreenKey = Key('assetManagementScreenKey');
  const ActivityScreen({
    Key key = assetManagementScreenKey,
  }) : super(key: key, route: '/activity');
  static const activityData = [
    {
      'transactionName': 'Topl transaction',
      'transactionDate': 'Received at 6:24 pm',
      'transactionLVLAmount': '+6,460',
      'transactionUSDAmount': '+123,23',
      'transactionType': 'received'
    },
    {
      'transactionName': 'Fees',
      'transactionDate': 'Fees at 6:24 pm',
      'transactionLVLAmount': '-0.00089',
      'transactionUSDAmount': '-1,49',
      'transactionType': 'fees'
    },
    {
      'transactionName': 'Ethereum',
      'transactionDate': 'Sent at 11:04 pm',
      'transactionLVLAmount': '-0.00089',
      'transactionUSDAmount': '-147.24',
      'transactionType': 'sent'
    },
  ];
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO SDK: Move up to a higher level widget
    ref.watch(loadedAssetsProvider);

    return Scaffold(
      backgroundColor: RibnColors.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.vRouter.historyBack();
                        },
                        iconSize: 24,
                        icon: SvgPicture.asset('assets/v2/icons/icon-filter.svg')),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Activity',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rational Display',
                    height: 32 / 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Text('Today, 03/17/2023'),
                SizedBox(height: 16),
                ...activityData.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActivityTransaction(
                      transactionName: e['transactionName']!,
                      transactionDateTime: e['transactionDate']!,
                      transactionAmountLVL: e['transactionLVLAmount']!,
                      transactionAmountUSD: e['transactionUSDAmount']!,
                      transactionType: e['transactionType']!,
                    ),
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('Yesterday, 03/16/2023'),
                SizedBox(height: 16),
                ...activityData.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActivityTransaction(
                      transactionName: e['transactionName']!,
                      transactionDateTime: e['transactionDate']!,
                      transactionAmountLVL: e['transactionLVLAmount']!,
                      transactionAmountUSD: e['transactionUSDAmount']!,
                      transactionType: e['transactionType']!,
                    ),
                  );
                }).toList(),
                SizedBox(height: 16),
                Text('03/14/2023'),
                SizedBox(height: 16),
                ...activityData.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActivityTransaction(
                      transactionName: e['transactionName']!,
                      transactionDateTime: e['transactionDate']!,
                      transactionAmountLVL: e['transactionLVLAmount']!,
                      transactionAmountUSD: e['transactionUSDAmount']!,
                      transactionType: e['transactionType']!,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
