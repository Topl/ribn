import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhraseConfirmationPage extends StatelessWidget {
  const SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Seed phrase confirmation page -- Onboarding page #5"),
            const SizedBox(
              height: 10,
            ),
            const Text("Confirm seed phrase here"),
            ContinueButton(
              onPressed: () {
                Keys.navigatorKey.currentState?.pushNamed(Routes.home);
              },
            )
          ],
        ),
      ),
    );
  }
}
