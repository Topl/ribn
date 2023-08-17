// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';

class ConfirmationSegmentedButton extends StatelessWidget {
  ConfirmationSegmentedButton({
    Key? key,
    this.selected,
    required this.words,
    this.index,
  })  : assert(words.contains(selected), "Selected needs to be available in word list"),
        super(key: key);

  final selected;
  final List<String> words;
  final index;

  @override
  Widget build(BuildContext context) {
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
            segments: words.map((e) => ButtonSegment<String>(value: e, label: Text(e))).toList(),
            selected: {selected},
          ),
        ],
      ),
    );
  }
}
