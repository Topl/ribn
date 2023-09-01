import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/shared/constants/assets.dart';

class CustomLoadingDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Color.fromRGBO(254, 254, 254, 0.64),
      child: Material(
        type: MaterialType.transparency,
        child: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.ribnLogoIcon, height: 120),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
