// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  Widget build(BuildContext context, WidgetRef ref) {
    // TODO SDK: Move up to a higher level widget
    ref.watch(loadedAssetsProvider);

    return Scaffold(
      backgroundColor: RibnColors.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFFE2E3E3),
                            ),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset('assets/v2/icons/topl-lvl.svg'),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Topl Transaction',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Rational Display',
                                color: Colors.black,
                                height: 20 / 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Received at 6:24 pm',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Rational Display',
                                  height: 20 / 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text(
                            '+6,460 LVL',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Rational Display',
                              height: 20 / 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '+123,25 USD',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Rational Display',
                                height: 20 / 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
