import 'package:bip_topl/bip_topl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/next_button.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';
import 'package:ribn/widgets/custom_text_field.dart';

/// This page allows the user to enter a known seed phrase in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when it is initiated from the login page.
class LoginRestoreWithSeedPhrasePage extends StatefulWidget {
  const LoginRestoreWithSeedPhrasePage({Key? key}) : super(key: key);

  @override
  _LoginRestoreWithSeedPhrasePageState createState() => _LoginRestoreWithSeedPhrasePageState();
}

class _LoginRestoreWithSeedPhrasePageState extends State<LoginRestoreWithSeedPhrasePage> {
  /// Controller for the seed phrase text field.
  final TextEditingController controller = TextEditingController();

  /// Seed phrase entered by the user.
  String seedPhrase = '';

  /// True if an invalid seed phrase is entered.
  bool invalidSeedPhraseEntered = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        seedPhrase = controller.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const RestoreWalletPageTitle(currPage: 1),
            const SizedBox(height: 30),
            SizedBox(
              width: 309,
              height: 198,
              child: Center(
                child: Text(
                  Strings.restoreWalletSeedPhraseDesc,
                  style: RibnTextStyles.smallBody.copyWith(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              width: 309,
              child: Text(
                Strings.enterSeedPhrase,
                style: RibnTextStyles.extH3,
              ),
            ),
            // seed phrase text field
            CustomTextField(
              controller: controller,
              hintText: Strings.hintSeedPhrase,
              height: 57,
              hasError: invalidSeedPhraseEntered,
            ),
            const Spacer(),
            NextButton(
              onPressed: () {
                final bool isSeedPhraseValid = validateMnemonic(seedPhrase, 'english');
                if (isSeedPhraseValid) {
                  StoreProvider.of<AppState>(context).dispatch(
                    NavigateToRoute(
                      Routes.restoreWalletnewPassword,
                      arguments: {
                        RecoverWalletCreds.seedPhrase: seedPhrase,
                      },
                    ),
                  );
                } else {
                  setState(() {
                    invalidSeedPhraseEntered = true;
                  });
                }
              },
            ),
            const SizedBox(height: 17),
          ],
        ),
      ),
    );
  }
}
