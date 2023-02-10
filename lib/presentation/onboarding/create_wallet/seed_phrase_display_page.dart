// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/providers/onboarding_provider.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/mobile_onboarding_progress_bar.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn/utils.dart';

class SeedPhraseDisplayPage extends HookConsumerWidget {
  static const Key copyKey = Key('copyKey');
  static const Key seedPhraseDisplayPageKey = Key('seedPhraseDisplayPageKey');
  static const Key seedPhraseDisplayConfirmationButtonKey =
      Key('seedPhraseDisplayConfirmationButtonKey');
  const SeedPhraseDisplayPage({Key key = seedPhraseDisplayPageKey}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool isXsWidth = width < 375.0 ? true : false;
    final bool isXsHeight = height < 667.0 ? true : false;
    final bool isXsScreenSize = isXsWidth && isXsHeight ? true : false;

    final onboardingState = ref.watch(onboardingProvider);

    final seedPhrase = onboardingState.mnemonic;

    final List<String> seedPhraseWordsList = seedPhrase.split(' ').toList();
    return Scaffold(
      body: OnboardingContainer(
        isXsScreenSize: isXsScreenSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kIsWeb ? const WebOnboardingAppBar(currStep: 0) : const SizedBox(),
            SizedBox(
              width: 200,
              child: Text(
                Strings.writeDownSeedPhrase,
                style: RibnToolkitTextStyles.onboardingH1.copyWith(letterSpacing: 0.5),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(RibnAssets.penPaperPng, width: 70),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: kIsWeb ? 40 : adaptHeight(0.03),
              ),
              child: const Text(
                Strings.writeDownSeedPhraseInExactOrder,
                style: RibnToolkitTextStyles.onboardingH3,
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 280,
                    maxWidth: 674,
                  ),
                  decoration: BoxDecoration(
                    color: RibnColors.greyText.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                          bottom: 20,
                        ),
                        child: _buildGrid(seedPhraseWordsList),
                      ),
                      kIsWeb
                          ? const SizedBox()
                          : Positioned(
                              bottom: 10,
                              right: 10,
                              child: _buildButton(
                                Strings.copy,
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: seedPhrase),
                                  );
                                },
                                width: 19,
                                height: 15,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 674,
              child: kIsWeb
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: _buildButton(
                          Strings.download,
                          onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                            DownloadAsFileAction(
                              Strings.seedPhraseFileName,
                              seedPhrase,
                            ),
                          ),
                          width: 30,
                          height: 23,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  renderIfMobile(
                    const MobileOnboardingProgressBar(currStep: 0),
                  ),
                  ConfirmationButton(
                    key: seedPhraseDisplayConfirmationButtonKey,
                    text: Strings.done,
                    onPressed: () {
                      Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhraseConfirm);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...List.generate(
          rows.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
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
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              '${idx + 1}. ',
              style: RibnToolkitTextStyles.h3
                  .copyWith(color: const Color(0xff00FFC5), letterSpacing: 0.5),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              word,
              style: RibnToolkitTextStyles.h3.copyWith(letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String buttonText, {
    VoidCallback? onPressed,
    required double width,
    required double height,
  }) {
    final String icon =
        buttonText == Strings.download ? RibnAssets.downloadPng : RibnAssets.contentCopyPng;
    return TextButton(
      key: copyKey,
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$buttonText ',
              style: RibnToolkitTextStyles.h3.copyWith(
                color: const Color(0xff00FFC5),
                letterSpacing: 0.5,
                height: kIsWeb ? 1 : 0,
              ),
            ),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  icon,
                  width: width,
                  height: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
