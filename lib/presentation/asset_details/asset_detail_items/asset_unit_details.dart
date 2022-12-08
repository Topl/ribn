import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';

import 'package:ribn_toolkit/widgets/atoms/hover_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the custom unit that's assigned to the asset.
class AssetUnitDetails extends StatelessWidget {
  /// The current unit assigned to the asset.
  final String? currUnit;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit button is pressed.
  final VoidCallback onEditPressed;

  const AssetUnitDetails({
    Key? key,
    required this.currUnit,
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
                text: 'Unit',
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
            text: currUnit ?? 'Undefined',
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.w300,)
      ],
    );
  }
}
