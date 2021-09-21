import 'package:flutter/material.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/seed_phrase_confirmation_container.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/continue_button.dart';

class SeedPhraseConfirmationPage extends StatelessWidget {
  const SeedPhraseConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeedPhraseConfirmationContainer(
      builder: (BuildContext context, SeedPhraseConfirmationViewModel vm) {
        return Scaffold(
          appBar: BaseAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Seed phrase confirmation page -- Onboarding page #5"),
                UIConstants.sizedBox,
                const Text("Confirm seed phrase here"),
                UIConstants.sizedBox,
                _showSelectedWords(vm.userSelectedIndices, vm),
                UIConstants.sizedBox,
                _buildShuffledMnemonicWords(vm.shuffledMnemonic, vm),
                UIConstants.bigSizedBox,
                ContinueButton(
                  enabled: vm.shuffledMnemonic.length == vm.userSelectedIndices.length,
                  onPressed: () => vm.verifyMnemonic(
                    vm.userSelectedIndices.map((idx) => vm.shuffledMnemonic[idx]).join(" "),
                  ),
                ),
                UIConstants.sizedBox,
                vm.mnemonicMismatchError
                    ? const Text(
                        "Failed to verify seed phrase. Make sure you are entering the correct seed phrase",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _showSelectedWords(List<int> selectedIndices, SeedPhraseConfirmationViewModel vm) {
    return Center(
      child: Wrap(
        children: selectedIndices
            .map(
              (idx) => Padding(
                padding: const EdgeInsets.all(UIConstants.generalPadding),
                child: GestureDetector(
                  onTap: () => vm.removeWord(idx),
                  child: Text(vm.shuffledMnemonic[idx]),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildShuffledMnemonicWords(List<String> shuffledMnemonic, SeedPhraseConfirmationViewModel vm) {
    Map<int, String> shuffledMnemonicMap = shuffledMnemonic.asMap();
    return Container(
      constraints: const BoxConstraints(
        maxHeight: UIConstants.mnemonicTileMaxHeight,
        maxWidth: UIConstants.mnemonicTileMaxWidth,
      ),
      child: GridView.count(
        crossAxisCount: UIConstants.mnemonicTileCrossAxisCount,
        children: shuffledMnemonicMap.keys
            .map((idx) => _buildWordContainer(idx, shuffledMnemonicMap[idx]!, vm))
            .toList(),
      ),
    );
  }

  Widget _buildWordContainer(int idx, String word, SeedPhraseConfirmationViewModel vm) {
    bool isSelectable = !vm.userSelectedIndices.contains(idx);
    return GestureDetector(
      onTap: isSelectable ? () => vm.selectWord(idx) : null,
      child: Card(
        color: isSelectable ? Colors.blue : Colors.blue[50],
        child: Center(
          child: Text(
            word,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
