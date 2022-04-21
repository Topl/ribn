import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/containers/seed_phrase_confirmation_container.dart';
import 'package:ribn/widgets/continue_button.dart';

/// Builds a grid containing the seed phrase words in a shuffled order.
/// Allows user to confirm the seed phrase by selecting the words in the correct order.
class SeedPhraseConfirmationPage extends StatelessWidget {
  final VoidCallback goToNextPage;
  const SeedPhraseConfirmationPage(this.goToNextPage, {Key? key}) : super(key: key);
  final Color idxColor = const Color(0xff00b5ab);
  final double idxContainerWidth = 35;
  final double idxContainerHeight = 20;
  final double wordContainerWidth = 130;
  final double wordContainerHeight = 40;

  @override
  Widget build(BuildContext context) {
    return SeedPhraseConfirmationContainer(
      builder: (BuildContext context, SeedPhraseConfirmationViewModel vm) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 315,
                  height: 100,
                  child: Text(
                    vm.finishedInputting ? Strings.seedPhraseConfirmed : Strings.confirmYourSeedPhrase,
                    style: RibnToolkitTextStyles.h1,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: 650,
                    child: Text(
                      vm.finishedInputting ? Strings.seedPhraseConfirmedDesc : Strings.confirmYourSeedPhraseDesc,
                      style: RibnToolkitTextStyles.body1,
                      textAlign: TextAlign.left,
                      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ),
                ),
                vm.finishedInputting ? const SizedBox() : _buildSeedPhraseGrid(vm, isShuffledGrid: true),
                _buildSeedPhraseGrid(vm, isShuffledGrid: false),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: vm.finishedInputting ? ContinueButton(Strings.cont, goToNextPage) : const SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds out the seedphrase grid for the shuffled words and the confirmed words
  Widget _buildSeedPhraseGrid(SeedPhraseConfirmationViewModel vm, {bool isShuffledGrid = false}) {
    final Map<int, String> shuffledSeedPhraseMap = vm.shuffledMnemonic.asMap();
    final Map<int, String> mnemonicMap = vm.mnemonicWordsList.asMap();
    final List<String> selectedWords = vm.userSelectedIndices.map((idx) => vm.shuffledMnemonic[idx]).toList();
    final Color borderColor = isShuffledGrid ? Colors.transparent : RibnColors.primary;
    return Container(
      height: 350,
      width: 650,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 50,
        mainAxisSpacing: 22,
        shrinkWrap: true,
        childAspectRatio: 4,
        children: isShuffledGrid
            ? shuffledSeedPhraseMap.keys
                .map((idx) => _buildShuffledWordContainer(idx, shuffledSeedPhraseMap[idx]!, vm))
                .toList()
            : mnemonicMap.keys.map((idx) => _buildConfirmedWordContainer(idx, selectedWords)).toList(),
      ),
    );
  }

  Widget _buildShuffledWordContainer(int idx, String word, SeedPhraseConfirmationViewModel vm) {
    final bool isSelected = vm.userSelectedIndices.contains(idx);
    final bool isNextWord = vm.mnemonicWordsList[vm.userSelectedIndices.length] == word;
    return Center(
      child: Row(
        children: [
          SizedBox(width: idxContainerWidth, height: idxContainerHeight),
          isSelected
              ? const SizedBox()
              : SizedBox(
                  width: wordContainerWidth,
                  height: wordContainerHeight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(RibnColors.accent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        word,
                        style: RibnToolkitTextStyles.body1,
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                      ),
                    ),
                    onPressed: isNextWord ? () => vm.selectWord(idx) : null,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildConfirmedWordContainer(int idx, List<String> selectedWords) {
    final String word = idx < selectedWords.length ? selectedWords[idx] : '';
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: idxContainerWidth,
            height: idxContainerHeight,
            child: Text(
              '${idx + 1}.',
              style: RibnToolkitTextStyles.body1Bold.copyWith(
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
                width: wordContainerWidth,
                height: wordContainerHeight,
                color: RibnColors.accent,
                child: Center(
                  child: Text(
                    word,
                    style: RibnToolkitTextStyles.body1Bold,
                    textAlign: TextAlign.center,
                    textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
