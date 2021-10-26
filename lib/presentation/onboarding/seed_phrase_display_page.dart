import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhraseDisplayPage extends StatelessWidget {
  final VoidCallback goToNextPage;
  final bool backButtonPressed;
  const SeedPhraseDisplayPage(this.goToNextPage, this.backButtonPressed, {Key? key}) : super(key: key);
  final Color idxColor = const Color(0xff00b5ab);

  @override
  Widget build(BuildContext context) {
    final List<String> seedPhraseList =
        StoreProvider.of<AppState>(context).state.onboardingState.mnemonic!.split(' ').toList();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 101,
                width: 312,
                child: Text(
                  backButtonPressed ? Strings.letsTryThatAgain : Strings.writeDownSeedPhrase,
                  style: RibnTextStyles.h1,
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SvgPicture.asset(
                backButtonPressed ? RibnAssets.winkIcon : RibnAssets.paperPenIcon,
                width: 55,
                height: 55,
              ),
            ),
            Text(
              backButtonPressed ? Strings.heyIWasntKidding : Strings.writeDownSeedPhraseDesc,
              style: RibnTextStyles.body1,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
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
            _buildDownloadButton(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ContinueButton(Strings.done, goToNextPage),
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
              style: RibnTextStyles.body1Bold.copyWith(
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
              style: RibnTextStyles.body1Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
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
            onPressed: () {},
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
                  style: RibnTextStyles.body1Bold.copyWith(color: RibnColors.primary),
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
