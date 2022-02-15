import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';

import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';

/// This page allows the wallet user to restore their wallet during the login flow.
///
/// The wallet user can choose between restoring wallet using a seed phrase or importing topl key.
class LoginRestoreWalletPage extends StatefulWidget {
  const LoginRestoreWalletPage({Key? key}) : super(key: key);

  @override
  _LoginRestoreWalletPageState createState() => _LoginRestoreWalletPageState();
}

class _LoginRestoreWalletPageState extends State<LoginRestoreWalletPage> {
  /// A map to keep track of which FAQ items are expanded.
  final Map<String, bool> faqItemExpanded = {
    Strings.seedPhraseDiffFromTopLevelKey: false,
    Strings.whereCanIFindMyTopLevelKey: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const RestoreWalletPageTitle(currPage: 0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  width: 309,
                  height: 80,
                  child: Center(
                    child: Text(
                      Strings.restoreWalletDesc,
                      style: RibnTextStyles.smallBody.copyWith(fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 309,
                child: Text('Choose Method', style: RibnTextStyles.extH3),
              ),
              _buildRestoreWalletOptions(),
              const SizedBox(height: 35),
              const SizedBox(
                width: 309,
                child: Text(
                  Strings.frequentlyAskedQuestions,
                  style: RibnTextStyles.extH3,
                ),
              ),
              _buildFaqListItem(Strings.seedPhraseDiffFromTopLevelKey, Strings.seedPhraseDiffFromTopLevelKeyDesc),
              _buildFaqListItem(Strings.whereCanIFindMyTopLevelKey, Strings.whereCanIFindMyTopLevelKeyDesc),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the restore option button, with labels [Strings.useSeedPhrase] or [Strings.importToplKey], depeding
  /// on [useSeedPhrase]'s value.
  ///
  /// Upon press, navigates to either [Routes.loginRestoreWalletSeedPhrase] or [Routes.loginRestoreWalletToplKey].
  Widget _buildRestoreOptionButton({required bool useSeedPhrase}) {
    final Color buttonColor = useSeedPhrase ? RibnColors.primary : const Color(0xffb1e7e1);
    final String text = useSeedPhrase ? Strings.useSeedPhrase : Strings.importToplKey;
    final Image icon = useSeedPhrase ? Image.asset(RibnAssets.keyLightIcon) : Image.asset(RibnAssets.keyDarkIcon);
    const TextStyle textStyle = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 17,
      fontWeight: FontWeight.w700,
    );
    return MaterialButton(
      onPressed: () {
        StoreProvider.of<AppState>(context).dispatch(
          NavigateToRoute(
            useSeedPhrase ? Routes.loginRestoreWalletSeedPhrase : Routes.loginRestoreWalletToplKey,
          ),
        );
      },
      padding: EdgeInsets.zero,
      child: Container(
        width: 149,
        height: 135,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(2.2),
          ),
          color: buttonColor,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 10,
              child: Text(
                text,
                style: textStyle.copyWith(color: useSeedPhrase ? RibnColors.whiteBackground : RibnColors.primary),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: icon,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRestoreWalletOptions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRestoreOptionButton(useSeedPhrase: true),
        const SizedBox(width: 13),
        _buildRestoreOptionButton(useSeedPhrase: false),
      ],
    );
  }

  /// Builds the FAQ list item.
  /// The [header] is the title of the [ExpansionTile]. Once expanded, the [desc] is also displayed.
  ///
  /// [faqItemExpanded] keeps track of the expansion state.
  Widget _buildFaqListItem(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.8),
        child: SizedBox(
          width: 309,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
              trailing: (faqItemExpanded[header] ?? false) ? const Icon(Icons.remove) : const Icon(Icons.add),
              iconColor: RibnColors.defaultText,
              onExpansionChanged: (bool val) {
                setState(() {
                  faqItemExpanded[header] = val;
                });
              },
              backgroundColor: const Color(0xffb1e7e1),
              collapsedBackgroundColor: const Color(0xffb1e7e1),
              title: Text(
                header,
                style: RibnTextStyles.dropdownButtonStyle.copyWith(color: RibnColors.defaultText),
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              children: [
                SizedBox(
                  width: 309,
                  child: Text(
                    desc,
                    style: RibnTextStyles.body1.copyWith(
                      color: const Color(0xff585858),
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
              ],
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
