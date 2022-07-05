import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/mobile/helpers.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/mobile/widgets/onboarding_page_padding.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/molecules/onboarding_progress_bar.dart';

class SeedPhraseDisplayPageMobile extends StatelessWidget {
  const SeedPhraseDisplayPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.onboardingState.mnemonic!,
      builder: (context, seedPhrase) {
        final List<String> seedPhraseWordsList = seedPhrase.split(' ').toList();
        return Scaffold(
          body: OnboardingContainer(
            child: OnboardingPagePadding(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 185,
                    child: Text(
                      Strings.writeDownSeedPhrase,
                      style: onboardingH1.copyWith(letterSpacing: 0.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(RibnAssets.penPaperPng, width: 70),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: adaptHeight(0.03)),
                    child: Text(
                      Strings.writeDownSeedPhraseInExactOrder,
                      style: onboardingH3,
                    ),
                  ),
                  Container(
                    height: adaptHeight(0.30),
                    width: adaptWidth(0.9),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: _buildCopyButton(seedPhrase),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const OnboardingProgressBar(numSteps: 4, currStep: 0),
                  const SizedBox(height: 10),
                  ConfirmationButton(
                    text: Strings.done,
                    onPressed: () => navigateToRoute(context, Routes.seedPhraseConfirm),
                  ),
                ],
              ),
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
        children.add(_buildWordGridItem(idx, word));
        rows.add(children);
        children = [];
      } else {
        children.add(_buildWordGridItem(idx, word));
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          rows.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: rows[index],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCopyButton(String seedphrase) {
    return TextButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: seedphrase));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Copy ',
              style: RibnToolkitTextStyles.h3.copyWith(
                color: const Color(0xff00FFC5),
                letterSpacing: 0.5,
              ),
            ),
            WidgetSpan(
              child: Image.asset(
                RibnAssets.contentCopyPng,
                width: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordGridItem(int idx, String word) {
    return SizedBox(
      width: 100,
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
}
