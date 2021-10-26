import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 40),
            child: SizedBox(
              width: 312,
              height: 100,
              child: Text(
                Strings.walletCreated,
                style: RibnTextStyles.h1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SvgPicture.asset(RibnAssets.logoCardIcon),
          SizedBox(
            height: 93,
            width: 683,
            child: Text(
              Strings.walletCreatedDesc,
              style: RibnTextStyles.bodyOne.copyWith(height: 2.36),
            ),
          ),
          const SizedBox(height: 30),
          ContinueButton(Strings.cont.toUpperCase(), () {
            StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.extensionInfo));
          }),
          const SizedBox(height: 60),
          SizedBox(
            width: 660,
            child: Row(
              children: [
                Text(
                  Strings.frequentlyAskedQuestions,
                  style: RibnTextStyles.body1Bold.copyWith(fontSize: 25),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
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
    );
  }

  Widget _buildFaqListItem(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: 660,
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
              style: RibnTextStyles.body1Bold,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
            children: [
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 30, bottom: 30),
                child: SizedBox(
                  width: 500,
                  child: Text(
                    desc,
                    style: RibnTextStyles.body1,
                    textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
              ),
            ],
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
