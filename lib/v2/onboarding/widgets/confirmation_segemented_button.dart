// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/onboarding/models/confirm_recovery_phrase_model.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';

class ConfirmationSegmentedButton extends HookWidget {
  ConfirmationSegmentedButton({
    Key? key,
    required this.words,
    required this.index,
  }) : super(key: key);

  final List<ConfirmRecoveryPhraseModel> words;
  final int index;

  @override
  Widget build(BuildContext context) {
    final selected = useState(words[1]);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Select Word #${index + 1}", style: RibnTextStyle.h3.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: 10),
          SegmentedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return RibnColors.primary;
                  }
                  return RibnColors.background;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return RibnColors.whiteColor;
                  }
                  return RibnColors.greyText;
                },
              ),
            ),
            showSelectedIcon: false,
            onSelectionChanged: (newSelection) {
              print(newSelection);
            },
            segments:
                words.map((e) => ButtonSegment<String>(value: e.phraseString, label: Text(e.phraseString))).toList(),
            selected: {selected.value},
          ),
        ],
      ),
    );
  }
}
