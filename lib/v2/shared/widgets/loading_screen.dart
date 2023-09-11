import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';

class LoadingScreen extends ScreenConsumerWidget {
  LoadingScreen({super.key}) : super(route: '/loading');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Image.asset(Assets.ribnLogoIcon, height: 120),
          ],
        ),
      ),
    );
  }
}
