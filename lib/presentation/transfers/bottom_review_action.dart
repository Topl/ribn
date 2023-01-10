// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomReviewAction extends StatelessWidget {
  const BottomReviewAction({
    Key? key,
    required this.children,
    this.transparentBackground = false,
    required this.maxHeight,
  }) : super(key: key);

  final dynamic children;
  final bool transparentBackground;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: transparentBackground
            ? null
            : const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40E2ECF9),
                    spreadRadius: 0,
                    blurRadius: 37.5,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
        child: BottomAppBar(
          color: transparentBackground ? Colors.transparent : Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, kIsWeb ? 16 : 0),
            child: children,
          ),
        ),
      ),
    );
  }
}
