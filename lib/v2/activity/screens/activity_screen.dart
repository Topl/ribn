// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/activity/providers/activity_provider.dart';
import 'package:ribn/v2/activity/widgets/activity_transaction.dart';
import 'package:ribn/v2/asset_managment/widgets/asset_footer/asset_bottom_nav.dart';
import 'package:ribn/v2/asset_managment/widgets/asset_footer/footer_button.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/asset_managment/providers/loaded_assets_provider.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
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
    final activities = ref.watch(activityProvider);

    return activities.when(
        data: (data) => Scaffold(
              backgroundColor: RibnColors.whiteBackground,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          Strings.activity,
                          style: RibnTextStyle.h1,
                        ),
                        SizedBox(height: 16),
                        ...data.keys.map(
                          (key) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('MM/dd/yyyy').format(DateTime.now()) == key ? 'Today, $key' : DateFormat('MM/dd/yyyy').format(DateTime.now().subtract(Duration(days: 1))) == key ? 'Yesterday, $key' : key}',
                                ),
                                SizedBox(height: 16),
                                ...?data[key]?.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: ActivityTransaction(
                                      transactionName: e.transactionName,
                                      transactionDateTime: e.transactionDateTime,
                                      transactionAmountLVL: e.transactionAmount,
                                      transactionAmountUSD: e.transactionAmountInUSD,
                                      transactionType: e.transactionTypeEnum,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: AssetBottomNavigation(),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FooterFloatingButton(),
            ),
        error: (_, __) => const SizedBox(),
        loading: () => const Text("loading"));
  }
}
