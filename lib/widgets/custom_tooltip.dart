import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/widgets/custom_close_button.dart';

/// A custom widget for displaying tooltips.
///
/// Displays a help icon which when pressed opens a draggable tooltip filled with [tooltipText].
class CustomToolTip extends StatefulWidget {
  /// Text to be displayed in the tooltip.
  final String tooltipText;

  const CustomToolTip({Key? key, required this.tooltipText}) : super(key: key);

  @override
  _CustomToolTipState createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> {
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) => const SizedBox());

  /// The [TextStyle] used for the tooltip text
  final TextStyle modaltextStyle = const TextStyle(
    color: Color(0xff323232),
    fontWeight: FontWeight.w400,
    fontFamily: 'Nunito',
    fontSize: 12.0,
    decoration: TextDecoration.none,
  );

  @override
  void dispose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(RibnAssets.helpIcon),
      onTap: () {
        // build tooltip if it is not already being displayed
        if (!overlayEntry.mounted) _buildTooltip(context);
      },
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
          left: offset.dx - 100,
          top: offset.dy + 10,
          child: GestureDetector(
            onPanUpdate: (details) {
              offset += details.delta;
              overlayState.setState(() {});
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  constraints: const BoxConstraints(),
                  decoration: BoxDecoration(
                    color: const Color(0xffeef9f8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.tooltipText,
                    style: modaltextStyle,
                  ),
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
