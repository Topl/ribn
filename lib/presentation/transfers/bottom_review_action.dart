import 'package:flutter/material.dart';
import 'package:ribn/utils.dart';

class BottomReviewAction extends StatelessWidget {
  const BottomReviewAction({Key? key, required this.children, this.transparentBackground = false}) : super(key: key);

  final Column children;
  final bool transparentBackground;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: adaptHeight(0.25)),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: children,
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
