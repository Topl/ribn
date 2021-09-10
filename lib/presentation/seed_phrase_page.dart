import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhrasePage extends StatelessWidget {
  const SeedPhrasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String seedPhrase = StoreProvider.of<AppState>(context).state.onboardingState.mnemonic ?? "";
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
            UIConstants.sizedBox,
            const Text("This is a seed phrase"),
            const Text("Please write it down. You will be asked to re-enter it on the next screen"),
            Container(
              height: UIConstants.mnemonicDisplayDimensions,
              width: UIConstants.mnemonicDisplayDimensions,
              color: Colors.white70,
              child: Text(
                seedPhrase,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ContinueButton(
              onPressed: () => Keys.navigatorKey.currentState!.pushNamed(Routes.seedPhraseConfirm),
            )
          ],
        ),
      ),
    );
  }
}
