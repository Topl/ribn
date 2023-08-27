// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';

import '../../../shared/theme.dart';
import 'network_selector_dropdown.dart';

class AssetScreenHeader extends StatelessWidget {
  const AssetScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFF7040EC).withAlpha(8),
          ],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // Green dot
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: RibnColors.success),
                  ),
                  SizedBox(width: 10),
                  NetworkSelectorDropDown(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      size: 28,
                      color: RibnColors.iconGrey,
                    ),
                    tooltip: 'settings',
                    onPressed: () {
                      //   TODO SDK: Implement settings
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.power_settings_new_outlined,
                      size: 28,
                      color: RibnColors.iconGrey,
                    ),
                    tooltip: 'Shutdown',
                    onPressed: () {
                      //   TODO SDK: Implement shutdown
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "4,012",
                        style: headlineLarge(context),
                      ),
                      Text(
                        "LVL",
                        style: titleLarge(context),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
