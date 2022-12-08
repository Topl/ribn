import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/hover_icon_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_h4_text_widget.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the icon that's assigned to the asset.
class AssetIconDetails extends StatelessWidget {
  /// The current icon assigned to the asset.
  final String? currIcon;

  /// True if this is currently being edited.
  final bool editingSectionOpened;

  /// Callback for when edit button is pressed.
  final VoidCallback onEditPressed;

  const AssetIconDetails({
    Key? key,
    required this.currIcon,
    required this.editingSectionOpened,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: Row(
            children: [
              const RibnH4TextWidget(
                  text: 'Icon',
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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 5),
          child: SizedBox(
            width: 20,
            height: 20,
            child: currIcon == null
                ? Image.asset(RibnAssets.undefinedIcon)
                : Image.asset(
                    currIcon!,
                    width: 31,
                  ),
          ),
        ),
      ],
    );
  }
}
