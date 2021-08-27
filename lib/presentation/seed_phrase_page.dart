import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhrasePage extends StatelessWidget {
  const SeedPhrasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ribn"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Seed phrase page -- Onboarding page #4"),
            const SizedBox(
              height: 10,
            ),
            const Text("This is a seed phrase"),
            const Text("Please write it down. You will be asked to re-enter it on the next screen"),
            Text(StoreProvider.of<AppState>(context).state.onboardingState.mnemonic ?? ""),
            ContinueButton(
              onPressed: () => Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhraseConfirm),
            )
          ],
        ),
      ),
    );
  }
}
