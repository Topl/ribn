import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/continue_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Page -- Onboarding page #1"),
            const SizedBox(
              height: 10,
            ),
            ContinueButton(
              onPressed: () {
                Keys.navigatorKey.currentState?.pushNamed(Routes.selectAction);
              },
            )
          ],
        ),
      ),
    );
  }
}
