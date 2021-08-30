import 'package:flutter/material.dart';
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
                const SizedBox(height: 10),
                const Text("Confirm seed phrase here"),
                const SizedBox(height: 10),
                _showSelectedWords(vm.userSelectedWords, vm),
                const SizedBox(height: 20),
                _buildShuffledMnemonicWords(vm.shuffledMnemonic, vm),
                const SizedBox(height: 20),
                ContinueButton(
                  enabled: vm.shuffledMnemonic.length == vm.userSelectedWords.length,
                  onPressed: () => vm.verifyMnemonic(vm.userSelectedWords.join(" ")),
                ),
                const SizedBox(height: 10),
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

  Widget _showSelectedWords(List<String> selectedWords, SeedPhraseConfirmationViewModel vm) {
    return Center(
      child: Wrap(
        children: selectedWords
            .map(
              (word) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => vm.removeWord(word),
                  child: Text(word),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildShuffledMnemonicWords(List<String> shuffledMnemonic, SeedPhraseConfirmationViewModel vm) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 250),
      child: GridView.count(
        crossAxisCount: 4,
        children: shuffledMnemonic.map((word) => _buildWordContainer(word, vm)).toList(),
      ),
    );
  }

  Widget _buildWordContainer(String word, SeedPhraseConfirmationViewModel vm) {
    bool isSelectable = !vm.userSelectedWords.contains(word);
    return Card(
      color: isSelectable ? Colors.blue : Colors.blue[50],
      child: Center(
        child: GestureDetector(
          child: Text(
            word,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: isSelectable ? () => vm.selectWord(word) : null,
        ),
      ),
    );
  }
}
