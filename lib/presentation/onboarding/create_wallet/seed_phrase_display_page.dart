import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

class SeedPhraseDisplayPage extends StatelessWidget {
  const SeedPhraseDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.onboardingState.mnemonic!,
      builder: (context, seedPhrase) {
        final List<String> seedPhraseWordsList = seedPhrase.split(' ').toList();
        return Scaffold(
          body: OnboardingContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kIsWeb ? const WebOnboardingAppBar(currStep: 0) : const SizedBox(),
                SizedBox(
                  child: Text(
                    Strings.writeDownSeedPhrase,
                    style: RibnToolkitTextStyles.onboardingH1.copyWith(letterSpacing: 0.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(RibnAssets.penPaperPng, width: 70),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kIsWeb ? 40 : adaptHeight(0.03)),
                  child: const Text(
                    Strings.writeDownSeedPhraseInExactOrder,
                    style: RibnToolkitTextStyles.onboardingH3,
                  ),
                ),
                Container(
                  height: kIsWeb ? 280 : adaptHeight(0.30),
                  width: kIsWeb ? 674 : adaptWidth(0.9),
                  decoration: BoxDecoration(
                    color: RibnColors.greyText.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: _buildGrid(seedPhraseWordsList),
                      ),
                      const Spacer(),
                      kIsWeb
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: _buildButton(
                                  Strings.copy,
                                  onPressed: () => Clipboard.setData(ClipboardData(text: seedPhrase)),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 674,
                  child: kIsWeb
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: _buildButton(
                            Strings.download,
                            onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                              DownloadAsFileAction(Strings.seedPhraseFileName, seedPhrase),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                adaptableSpacer(),
                renderIfMobile(const MobileOnboardingProgressBar(currStep: 0)),
                ConfirmationButton(
                  text: Strings.done,
                  onPressed: () => navigateToRoute(context, Routes.seedPhraseConfirm),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid(List<String> wordsList) {
    List<Widget> children = [];
    final List<List<Widget>> rows = [];
    wordsList.asMap().forEach((idx, word) {
      if ((idx + 1) % 3 == 0) {
        children.add(_buildGridItem(idx, word));
        rows.add(children);
        children = [];
      } else {
        children.add(_buildGridItem(idx, word));
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          rows.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: kIsWeb ? 20 : 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: rows[index],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildGridItem(int idx, String word) {
    return SizedBox(
      width: kIsWeb ? 150 : 100,
      // color: Colors.green,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              '${idx + 1}. ',
              style: RibnToolkitTextStyles.h3.copyWith(color: const Color(0xff00FFC5), letterSpacing: 0.5),
            ),
          ),
          Text(
            word,
            style: RibnToolkitTextStyles.h3.copyWith(letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String buttonText, {
    VoidCallback? onPressed,
  }) {
    final String icon = buttonText == Strings.download ? RibnAssets.downloadPng : RibnAssets.contentCopyPng;
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$buttonText ',
              style: RibnToolkitTextStyles.h3.copyWith(
                color: const Color(0xff00FFC5),
                letterSpacing: 0.5,
              ),
            ),
            WidgetSpan(
              child: Image.asset(
                icon,
                width: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
