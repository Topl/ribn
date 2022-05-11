import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// Wallet created success page.
/// Displays several FAQs to the user.
class WalletCreatedPage extends StatefulWidget {
  const WalletCreatedPage({Key? key}) : super(key: key);

  @override
  State<WalletCreatedPage> createState() => _WalletCreatedPageState();
}

class _WalletCreatedPageState extends State<WalletCreatedPage> {
  final Map<String, bool> faqExpanded = {
    Strings.howCanIKeepMySeedPhraseSecure: false,
    Strings.howIsASeedPhraseDifferent: false,
    Strings.howIsMySeedPhraseUnrecoverable: false,
  };
  final Color dividerColor = const Color.fromRGBO(148, 162, 171, 0.47);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 315,
              height: 100,
              child: Text(
                Strings.walletCreated,
                style: RibnToolkitTextStyles.h1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(RibnAssets.logoCardIcon),
            const SizedBox(
              height: 95,
              width: 680,
              child: Text(
                Strings.walletCreatedDesc,
                style: RibnToolkitTextStyles.body1,
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
            const SizedBox(height: 30),
            LargeButton(
              buttonChild: Text(
                Strings.cont,
                style: RibnToolkitTextStyles.btnLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              backgroundColor: RibnColors.primary,
              hoverColor: RibnColors.primaryButtonHover,
              dropShadowColor: RibnColors.primaryButtonShadow,
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                NavigateToRoute(Routes.extensionInfo),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 660,
              child: Row(
                children: [
                  Text(
                    Strings.frequentlyAskedQuestions,
                    style: RibnToolkitTextStyles.body1Bold.copyWith(fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildFaqListItem(
              Strings.howCanIKeepMySeedPhraseSecure,
              Strings.howCanIKeepMySeedPhraseSecureAns,
            ),
            _buildFaqListItem(
              Strings.howIsASeedPhraseDifferent,
              Strings.howIsASeedPhraseDifferentAns,
            ),
            _buildFaqListItem(
              Strings.howIsMySeedPhraseUnrecoverable,
              Strings.howIsMySeedPhraseUnrecoverableAns,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqListItem(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: 660,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 30),
              trailing: faqExpanded[header]! ? const Icon(Icons.remove) : const Icon(Icons.add),
              iconColor: RibnColors.defaultText,
              onExpansionChanged: (bool val) {
                setState(() {
                  faqExpanded[header] = val;
                });
              },
              backgroundColor: RibnColors.accent,
              collapsedBackgroundColor: RibnColors.accent,
              title: Text(
                header,
                style: RibnToolkitTextStyles.body1Bold,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              children: [
                Container(
                  color: dividerColor,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30, bottom: 30),
                  child: SizedBox(
                    width: 500,
                    child: Text(
                      desc,
                      style: RibnToolkitTextStyles.body1,
                      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
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
