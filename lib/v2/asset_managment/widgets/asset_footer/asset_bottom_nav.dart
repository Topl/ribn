import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/providers/bottom_nav_provider.dart';
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:vrouter/vrouter.dart';

class AssetBottomNavigation extends HookConsumerWidget {
  AssetBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    void _onTabTapped(int index) {
      ref.watch(currentIndexProvider.notifier).setIndex(index);
      if (currentIndex == 0) {
        // Navigate to Assets screen
        context.vRouter.to('/assets');
      } else if (currentIndex == 1) {
        // Navigate to Activity screen
        context.vRouter.to('/activity');
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE7E8E8),
        border: Border(
          top: BorderSide(color: Color(0xFFE7E8E8), width: 1.0),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: RibnColors.whiteBackground,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'Assets', icon: SvgPicture.asset(Assets.wallet), activeIcon: SvgPicture.asset(Assets.walletIcon)),
          BottomNavigationBarItem(
            label: 'Activity',
            icon: SvgPicture.asset(Assets.scheduleIcon),
            activeIcon: SvgPicture.asset(Assets.schedule),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: RibnColors.primary,
        selectedIconTheme: IconThemeData(color: RibnColors.primary),
        onTap: _onTabTapped,
      ),
    );
  }
}
