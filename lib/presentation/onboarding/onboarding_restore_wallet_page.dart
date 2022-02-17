import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// This page allows the wallet user to restore their wallet during onboarding.
///
/// The wallet user can choose between restoring wallet using a seed phrase or importing topl key.
class OnboardingRestoreWalletPage extends StatefulWidget {
  const OnboardingRestoreWalletPage({Key? key}) : super(key: key);

  @override
  State<OnboardingRestoreWalletPage> createState() => _OnboardingRestoreWalletPageState();
}

class _OnboardingRestoreWalletPageState extends State<OnboardingRestoreWalletPage> {
  /// A map to keep track of which FAQ items are expanded.
  final Map<String, bool> faqItemExpanded = {
    Strings.seedPhraseDiffFromTopLevelKey: false,
    Strings.whereCanIFindMyTopLevelKey: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingAppBar(onBackPressed: () => Navigator.of(context).pop()),
            _buildTitle(),
            _buildRestoreWalletOptions(),
            const SizedBox(height: 55),
            const SizedBox(
              width: 734,
              child: Text(Strings.frequentlyAskedQuestions, style: RibnTextStyles.extH2),
            ),
            const SizedBox(height: 30),
            _buildFaqListItem(Strings.seedPhraseDiffFromTopLevelKey, Strings.seedPhraseDiffFromTopLevelKeyDesc),
            _buildFaqListItem(Strings.whereCanIFindMyTopLevelKey, Strings.whereCanIFindMyTopLevelKeyDesc),
          ],
        ),
      ),
    );
  }

  /// Builds the title of the page.
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 22, bottom: 80),
      child: Text(
        Strings.chooseMethod,
        style: RibnTextStyles.h1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRestoreWalletOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRestoreOptionContainer(useSeedPhrase: true),
        const SizedBox(width: 84),
        _buildRestoreOptionContainer(useSeedPhrase: false),
      ],
    );
  }

  /// Builds the restore option button, with labels [Strings.useSeedPhrase] or [Strings.importToplKey], depeding
  /// on [useSeedPhrase]'s value.
  Widget _buildRestoreOptionContainer({required bool useSeedPhrase}) {
    final Color boxColor = useSeedPhrase ? RibnColors.primary : RibnColors.accent;
    final String text = useSeedPhrase ? Strings.useSeedPhrase : Strings.importToplKey;
    final String navigateToRoute =
        useSeedPhrase ? Routes.onboardingRestoreWalletWithMnemonic : Routes.onboardingRestoreWalletWithToplKey;
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(navigateToRoute));
      },
      child: Container(
        width: 325,
        height: 217,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  /// Builds the FAQ list item.
  /// The [header] is the title of the [ExpansionTile]. Once expanded, the [desc] is displayed in the container.
  ///
  /// [faqItemExpanded] is updated accordingly to keep track of the expansion state.
  Widget _buildFaqListItem(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.8),
        child: SizedBox(
          width: 734,
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
                  width: 734,
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
