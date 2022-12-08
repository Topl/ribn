// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/hover_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the custom long name assigned to the asset.
class AssetLongNameDetails extends StatelessWidget {
  /// The current long name assigned to the asset.
  final String? currLongName;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit is pressed.
  final VoidCallback onEditPressed;

  const AssetLongNameDetails({
    Key? key,
    required this.currLongName,
    required this.onEditPressed,
    required this.editingSectionOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const RibnH4TextWidget(
                text: 'Asset name',
                textAlignment: TextAlign.justify,
                textColor: RibnColors.defaultText,
                fontWeight: FontWeight.w500,),
            const Spacer(),
            editingSectionOpened
                ? const SizedBox()
                : HoverIconButton(
                    buttonText: const RibnFont12TextWidget(
                        text: 'Edit',
                        textAlignment: TextAlign.justify,
                        textColor: RibnColors.primary,
                        fontWeight: FontWeight.w300,),
                    buttonIcon: Image.asset(RibnAssets.editIcon),
                    onPressed: onEditPressed,
                  ),
          ],
        ),
        const SizedBox(height: 3),
        RibnFont12TextWidget(
            text: currLongName ?? 'Undefined',
            textAlignment: TextAlign.justify,
            textColor: RibnColors.primary,
            fontWeight: FontWeight.w300,)
      ],
    );
  }
}
