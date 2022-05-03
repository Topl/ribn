import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';

/// An input field used on transfer input pages.
///
/// Allows the user to add a note to the transaction.
class NoteField extends StatelessWidget {
  /// Controller for the asset short name.
  final TextEditingController controller;

  /// Length of the note text entered.
  final int noteLength;

  /// Max length of the note.
  final maxNoteLength = 127;

  const NoteField({
    required this.controller,
    required this.noteLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool maxLimitReached = noteLength >= maxNoteLength;
    final Color counterBoxColor = maxLimitReached ? const Color(0xFFFFE5E5) : const Color(0xffefefef);
    final Color counterBorderColor = maxLimitReached ? const Color(0xffE80E00) : Colors.transparent;

    return CustomInputField(
      itemLabel: Strings.note,
      item: Stack(
        children: [
          // text field for the note
          CustomTextField(
            controller: controller,
            hintText: Strings.noteHint,
            height: 80,
            maxLength: maxNoteLength,
            textAlignVertical: TextAlignVertical.top,
          ),
          // character count indicator
          Positioned(
            right: 5,
            bottom: 10,
            child: Container(
              child: Center(
                child: Text(
                  (maxNoteLength - noteLength).toString(),
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              width: 37,
              height: 25,
              decoration: BoxDecoration(
                color: counterBoxColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: counterBorderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
