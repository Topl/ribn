import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/v2/shared/constants/assets.dart';

import '../../../shared/constants/colors.dart';

class AssetBottomNavigation extends StatelessWidget {
  const AssetBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            icon: SvgPicture.asset(Assets.walletIcon),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.scheduleIcon),
            label: 'Activity',
          ),
        ],
        selectedItemColor: RibnColors.primary,
      ),
    );
  }
}
