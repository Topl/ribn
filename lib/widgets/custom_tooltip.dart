import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/widgets/custom_close_button.dart';

/// A custom widget for displaying tooltips.
///
/// Displays [toolTipIcon] which, when pressed, opens a draggable tooltip, i.e. [toolTipChild].
class CustomToolTip extends StatefulWidget {
  /// The icon associated with the tooltip.
  final Widget? toolTipIcon;

  /// The main tooltip widget that is displayed when [toolTipIcon] is pressed.
  final Widget toolTipChild;

  /// Integer to offset the tooltip on the x axis to fit on screen.
  final int offsetPositionLeftValue;

  /// A color value to change the background.
  final Color toolTipBackgroundColor;

  const CustomToolTip({
    Key? key,
    this.offsetPositionLeftValue = 150,
    this.toolTipBackgroundColor = const Color(0xffeef9f8),
    this.toolTipIcon,
    required this.toolTipChild,
  }) : super(key: key);

  @override
  _CustomToolTipState createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> {
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) => const SizedBox());

  @override
  void dispose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Remove existing overlay on rebuild
    if (overlayEntry.mounted) overlayEntry.remove();
    return Container(
      margin: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        child: widget.toolTipIcon ??
            Image.asset(
              RibnAssets.roundInfoCircle,
              width: 10,
            ),
        onTap: () {
          // build tooltip if it is not already being displayed
          if (!overlayEntry.mounted) _buildTooltip(context);
        },
      ),
    );
  }

  /// Builds the Tooltip with the provided tooltip text.
  ///
  /// [overlayEntry] is assigned a new widget, i.e. the tooltip bubble
  /// and inserted into the [overlayState].
  void _buildTooltip(BuildContext context) async {
    final OverlayState overlayState = Overlay.of(context)!;
    final RenderBox renderbox = context.findRenderObject() as RenderBox;
    // Position of the tooltip
    Offset offset = renderbox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx - widget.offsetPositionLeftValue,
          top: offset.dy + 10,
          child: GestureDetector(
            onPanUpdate: (details) {
              // allow dragging the tooltip container
              offset += details.delta;
              overlayState.setState(() {});
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  constraints: const BoxConstraints(),
                  decoration: BoxDecoration(
                    color: widget.toolTipBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: widget.toolTipChild,
                ),
                // close button for dismissing the tooltip
                Positioned(
                  right: 0,
                  top: 0,
                  child: CustomCloseButton(
                    iconSize: 10,
                    onPressed: () => overlayEntry.remove(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);
  }
}
