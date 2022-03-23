import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/widgets/custom_close_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// A custom widget for displaying tooltips.
///
/// Displays a help icon which when pressed opens a draggable tooltip filled with [tooltipText].
class CustomToolTip extends StatefulWidget {
  /// Text to be displayed in the tooltip.
  final String tooltipText;
  // Alternative text to be displayed below the main text.
  final String? alternateTooltipText;
  // Integer to offset the tooltip on the x axis to fit on screen.
  final int offsetPositionLeftValue;
  // An SVG icon which acts as the trigger to open the tooltip.
  final SvgPicture tooltipIcon;
  // A color value to change the background.
  final Color toolTipBackgroundColor;
  // The text for the tooltip link.
  final String? tooltipUrlText;
  // The url for the tooltip link.
  final String? tooltipUrl;
  // Conditional for making the tooltipText bold like a title.
  final bool? tooltipTextBold;

  const CustomToolTip({
    Key? key,
    required this.tooltipText,
    required this.offsetPositionLeftValue,
    required this.tooltipIcon,
    required this.toolTipBackgroundColor,
    this.tooltipUrlText,
    this.tooltipUrl,
    this.alternateTooltipText,
    this.tooltipTextBold,
  }) : super(key: key);

  @override
  _CustomToolTipState createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> {
  OverlayEntry overlayEntry =
      OverlayEntry(builder: (context) => const SizedBox());

  @override
  void dispose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 2),
      child: GestureDetector(
        child: widget.tooltipIcon,
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
              offset += details.delta;
              overlayState.setState(() {});
            },
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.tooltipText,
                          style: TextStyle(
                            fontWeight: widget.tooltipTextBold == true
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                        if (widget.tooltipUrl != null &&
                            widget.tooltipUrlText != null)
                          WidgetSpan(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: GestureDetector(
                                onTap: () async {
                                  final url = widget.tooltipUrl;
                                  if (await canLaunch(url!)) await launch(url);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      widget.tooltipUrlText!,
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w400,
                                        color: RibnColors.primary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: SvgPicture.asset(
                                        RibnAssets.openInNewWindow,
                                        width: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (widget.alternateTooltipText != null)
                          TextSpan(
                            text: '\n${widget.alternateTooltipText}',
                          ),
                      ],
                    ),
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
