import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// Displays a grid of the seed phrase words listed in the correct order.
class SeedPhraseDisplayPage extends StatelessWidget {
  final VoidCallback goToNextPage;
  final bool backButtonPressed;
  const SeedPhraseDisplayPage(this.goToNextPage, this.backButtonPressed, {Key? key}) : super(key: key);
  final Color idxColor = const Color(0xff00b5ab);

  @override
  Widget build(BuildContext context) {
    final List<String> seedPhraseList =
        StoreProvider.of<AppState>(context).state.onboardingState.mnemonic!.split(' ').toList();
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 100,
                width: 315,
                child: Text(
                  backButtonPressed ? Strings.letsTryThatAgain : Strings.writeDownSeedPhrase,
                  style: RibnToolkitTextStyles.h1,
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: backButtonPressed
                  ? SvgPicture.asset(
                      RibnAssets.winkIcon,
                      width: 55,
                    )
                  : Image.asset(
                      RibnAssets.seedPhraseCreatedIcon,
                      width: 65,
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              width: 690,
              child: Text(
                backButtonPressed ? Strings.heyIWasntKidding : Strings.writeDownSeedPhraseDesc,
                style: RibnToolkitTextStyles.body1,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 350,
              width: 650,
              decoration: BoxDecoration(
                color: RibnColors.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: (100 / 25),
                  children: List.generate(seedPhraseList.length, (index) => index)
                      .map((idx) => _buildWordGridItem(idx, seedPhraseList[idx]))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDownloadButton(context, seedPhraseList),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: LargeButton(
                buttonChild: Text(
                  Strings.done,
                  style: RibnToolkitTextStyles.btnLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: RibnColors.primary,
                hoverColor: RibnColors.primaryButtonHover,
                dropShadowColor: RibnColors.primaryButtonShadow,
                onPressed: goToNextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each word in the grid.
  Widget _buildWordGridItem(int index, String word) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 20,
            child: Text(
              '${index + 1}.',
              style: RibnToolkitTextStyles.body1Bold.copyWith(
                color: idxColor,
              ),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              word,
              style: RibnToolkitTextStyles.body1Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context, List<String> seedPhraseList) {
    final String seedPhrase = seedPhraseList.join(' ');
    return SizedBox(
      width: 650,
      child: Row(
        children: [
          const Spacer(),
          MaterialButton(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            minWidth: 100,
            height: 45,
            onPressed: () => StoreProvider.of<AppState>(context)
                .dispatch(DownloadAsFileAction(Strings.seedPhraseFileName, seedPhrase)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 33,
                  height: 33,
                  child: SvgPicture.asset(
                    RibnAssets.downloadIcon,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  Strings.download,
                  style: RibnToolkitTextStyles.body1Bold.copyWith(color: RibnColors.primary),
                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
