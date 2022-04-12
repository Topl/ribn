import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

/// A custom drop down widget.
///
/// The [flutter_portal] library is leveraged to develop a custom drop down.
///
/// Note: In the build method, the outer [PortalEntry] is added to handle dismissing the dropdown menu, in case
/// the user clicks elesewhere on the screen, hence the usage of [GestureDetector] and [onDismissed].
class CustomDropDown extends StatefulWidget {
  /// The dropdown button widget that opens the dropdown menu when pressed.
  final Widget dropdownButton;

  /// The widget that's displayed upon the [dropdownButton] being pressed.
  final Widget dropdownChild;

  /// Alignment of the [dropdownButton] with respect to the [dropdownChild].
  final Alignment childAlignment;

  /// Alignment of the [dropdownChild] with respect to the [dropdownButton].
  final Alignment dropDownAlignment;

  /// True if [dropdownChild] is currently visible.
  final bool visible;

  /// Callback function to handle dismiss event.
  final Function()? onDismissed;
  const CustomDropDown({
    Key? key,
    required this.dropdownButton,
    required this.dropdownChild,
    required this.childAlignment,
    required this.dropDownAlignment,
    required this.visible,
    required this.onDismissed,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return PortalEntry(
      visible: widget.visible,
      portal: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onDismissed,
      ),
      child: PortalEntry(
        visible: widget.visible,
        child: widget.dropdownButton,
        portal: widget.dropdownChild,
        childAnchor: widget.childAlignment,
        portalAnchor: widget.dropDownAlignment,
      ),
    );
  }
}
