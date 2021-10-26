import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/seed_phrase_confirmation_container.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhraseConfirmationPage extends StatelessWidget {
  final VoidCallback goToNextPage;
  SeedPhraseConfirmationPage(this.goToNextPage, {Key? key}) : super(key: key);
  final Color idxColor = const Color(0xff00b5ab);

  @override
  Widget build(BuildContext context) {
    return SeedPhraseConfirmationContainer(
      builder: (BuildContext context, SeedPhraseConfirmationViewModel vm) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                SizedBox(
                  width: 312,
                  height: 101,
                  child: Text(
                    vm.finishedInputting ? Strings.seedPhraseConfirmed : Strings.confirmYourSeedPhrase,
                    style: RibnTextStyles.headingOne,
                    textAlign: TextAlign.center,
                  ),
                ),
                // add icon here
                vm.finishedInputting
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset(RibnAssets.seedPhraseConfirmedIcon),
                      )
                    : const SizedBox(),
                const SizedBox(height: 40),
                SizedBox(
                  width: 634,
                  height: 100,
                  child: Text(
                    vm.finishedInputting ? Strings.seedPhraseConfirmedDesc : Strings.confirmYourSeedPhraseDesc,
                    style: RibnTextStyles.body1,
                    textAlign: TextAlign.left,
                    textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
                vm.finishedInputting ? const SizedBox() : _buildShuffledSeedPhraseGrid(vm),
                _buildConfirmedSeedPhraseGrid(vm),
                const SizedBox(height: 20),
                vm.finishedInputting ? ContinueButton(Strings.cont, goToNextPage) : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShuffledSeedPhraseGrid(SeedPhraseConfirmationViewModel vm) {
    final Map<int, String> shuffledSeedPhraseMap = vm.shuffledMnemonic.asMap();
    return SizedBox(
      height: 350,
      width: 650,
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 65,
        mainAxisSpacing: 25,
        shrinkWrap: true,
        childAspectRatio: (129 / 37),
        children:
            shuffledSeedPhraseMap.keys.map((idx) => _buildWordContainer(idx, shuffledSeedPhraseMap[idx]!, vm)).toList(),
      ),
    );
  }

  Widget _buildWordContainer(int idx, String word, SeedPhraseConfirmationViewModel vm) {
    final bool isSelected = vm.userSelectedIndices.contains(idx);
    final bool isNextWord = vm.mnemonicWordsList[vm.userSelectedIndices.length] == word;
    return isSelected
        ? const SizedBox()
        : TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(RibnColors.accent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            child: Text(word, style: RibnTextStyles.bodyOne),
            onPressed: isNextWord ? () => vm.selectWord(idx) : null,
          );
  }

  Widget _buildConfirmedSeedPhraseGrid(SeedPhraseConfirmationViewModel vm) {
    final Map<int, String> shuffledMap = vm.shuffledMnemonic.asMap();
    return Container(
      height: 350,
      width: 650,
      decoration: BoxDecoration(
        border: Border.all(color: RibnColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 40,
        mainAxisSpacing: 22,
        shrinkWrap: true,
        childAspectRatio: (150 / 37),
        children:
            shuffledMap.keys.map((idx) => _buildSelectedWordContainer(idx, vm.shuffledMnemonic[idx], vm)).toList(),
      ),
    );
  }

  Widget _buildSelectedWordContainer(int idx, String word, SeedPhraseConfirmationViewModel vm) {
    final bool isSelected = vm.userSelectedIndices.contains(idx);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 20,
            child: Text(
              '${idx + 1}.',
              style: RibnTextStyles.body1Bold.copyWith(
                color: idxColor,
              ),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
              ),
            ),
          ),
          DottedBorder(
            color: Colors.black,
            strokeWidth: 1.5,
            padding: EdgeInsets.zero,
            borderType: BorderType.RRect,
            radius: const Radius.circular(26),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Container(
                width: 129,
                height: 37,
                color: isSelected ? RibnColors.accent : Colors.transparent,
                child: isSelected
                    ? Center(
                        child: Text(
                          word,
                          style: RibnTextStyles.body1Bold,
                          textAlign: TextAlign.center,
                          textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
