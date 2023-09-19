import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/onboarding/screens/login_screen.dart';
import 'package:ribn/v2/onboarding/screens/welcome_screen.dart';
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/user/providers/user_provider.dart';

class LoadingScreen extends ScreenConsumerWidget {
  LoadingScreen({super.key}) : super(route: '/loading');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserNotifier?>(
        future: _loadUser(ref),
        builder: (context, snapshot) {
          final user = snapshot.data;
          Future<Widget> widgetFuture = _buildWidget(user);

          return FutureBuilder<Widget>(
            future: widgetFuture,
            builder: (context, widgetSnapshot) {
              if (widgetSnapshot.connectionState == ConnectionState.waiting) {
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
              } else {
                return widgetSnapshot.data ?? WelcomePage();
              }
            },
          );
        });
  }

// This function loads user data asynchronously and returns a Future<UserNotifier>.
  Future<UserNotifier> _loadUser(WidgetRef ref) async {
    final userProviderState = await ref.watch(userProvider.notifier);
    return userProviderState;
  }
}

// This function builds and returns a Future<Widget> based on the provided UserNotifier data.
Future<Widget> _buildWidget(UserNotifier? user) async {
  if (await user?.isUserSaved() ?? false) {
    return LoginScreen();
  } else {
    return WelcomePage();
  }
}
