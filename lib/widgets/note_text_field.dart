import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';

/// A widget that builds the [TextField] neccessary for adding metadata/note during the transfer flows.
class NoteTextField extends StatelessWidget {
  const NoteTextField({required this.noteController, required this.noteLength, Key? key}) : super(key: key);
  final TextEditingController noteController;
  final int noteLength;
  final maxNoteLength = 127;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 310,
          height: 80,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              color: RibnColors.defaultText,
            ),
            controller: noteController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: maxNoteLength,
            decoration: const InputDecoration(
              isDense: true,
              counterText: '',
              hintText: Strings.noteHint,
              hintStyle: RibnTextStyles.hintStyle,
              border: OutlineInputBorder(),
              filled: true,
              contentPadding: EdgeInsets.all(5),
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 10,
          child: Container(
            child: Center(
              child: Text(
                noteLength.toString(),
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            width: 37,
            height: 25,
            decoration: BoxDecoration(
              color: noteLength < maxNoteLength ? const Color(0xffefefef) : RibnColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }
}
