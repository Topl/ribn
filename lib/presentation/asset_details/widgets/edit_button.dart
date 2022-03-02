import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/styles.dart';

/// The edit button used for asset detail items that can be edited.
class EditButton extends StatefulWidget {
  /// A callback function to handle onPressed events.
  final VoidCallback onEditPressed;

  const EditButton({
    Key? key,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  bool showEditIcon = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (pointerEvent) {
        setState(() {
          showEditIcon = true;
        });
      },
      onExit: (pointerEvent) {
        setState(() {
          showEditIcon = false;
        });
      },
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: widget.onEditPressed,
        child: SizedBox(
          width: 35,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              showEditIcon ? Image.asset(RibnAssets.editIcon) : const SizedBox(),
              const Spacer(),
              Text(
                'Edit',
                style: RibnTextStyles.dropdownButtonStyle.copyWith(color: RibnColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
