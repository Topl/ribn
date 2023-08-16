// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/build_context_extensions.dart';
import 'package:ribn/v2/shared/widgets/icon_button_text.dart';

/// QQQQ move to /widgets folder

/// A widget that displays the recovery phrase and allows it to be copied to the clipboard.
class RecoveryPhraseDisplayWidget extends StatelessWidget {
  /// Creates a RecoveryPhraseDisplayWidget.
  ///
  /// The [recoveryPhrase] parameter must not be empty.
  RecoveryPhraseDisplayWidget(this.recoveryPhrase)
      : assert(recoveryPhrase.isNotEmpty, 'Recovery phrase list must not be empty.');

  final List<String> recoveryPhrase;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RibnColors.somewhatBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildColumns(recoveryPhrase)),
          SizedBox(height: 10),
          IconButtonText(
            text: Strings.copy,
            icon: Icons.copy,
            semanticLabel: Strings.semanticCopy,
            textStyle: RibnTextStyle.h3Grey,
            onPressed: () {
              // TODO: Rethink snack-bars
              context.showSnackBar("Recovery phrase copied to clipboard");
              copyToClipboard(recoveryPhrase);
            },
          )
        ],
      ),
    );
  }

  /// Returns two columns of [Text] widgets, evenly dividing the items in [list].
  ///
  /// Each [Text] widget will display the corresponding string from [list],
  /// prefixed with its index in the list.
  List<Widget> buildColumns(List<String> list) {
    assert(list.isNotEmpty, 'List must not be empty.');

    final itemsPerColumn = (list.length / 2).ceil();
    final firstColumn = list.take(itemsPerColumn).toList();
    final secondColumn = list.skip(itemsPerColumn).toList();

    return [
      Expanded(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: firstColumn
              .asMap()
              .map(
                (index, item) => MapEntry(
                  index,
                  buildText('${format(index + 1, item)}'),
                ),
              )
              .values
              .toList(),
        ),
      ),
      Expanded(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: secondColumn
              .asMap()
              .map(
                (index, item) => MapEntry(
                  index,
                  buildText('${format(index + itemsPerColumn + 1, item)}'),
                ),
              )
              .values
              .toList(),
        ),
      ),
    ];
  }

  /// Builds [Text] widgets with correct formatting
  Widget buildText(String text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: RibnTextStyle.h3,
        ));
  }

  /// Formats a string [value] with its corresponding index [index].
  ///
  /// Returns a string with the format: '$index.    $value'.
  String format(int index, String value) {
    return '$index.    $value';
  }

  /// Copies the given [strings] to the clipboard.
  Future<void> copyToClipboard(List<String> strings) async {
    final String data = strings.join('\n');
    await Clipboard.setData(ClipboardData(text: data));
  }
}
