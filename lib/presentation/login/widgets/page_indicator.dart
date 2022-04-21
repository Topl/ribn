import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';

/// A custom page indicator used on the 'restore wallet' pages.
///
/// Builds a row of [Container]s, where the color of each is updated based on [currPage]'s value.
class CustomPageIndicator extends StatelessWidget {
  /// The current page being viewed.
  final int currPage;

  /// The total number of pages in the restore wallet flow.
  final int totalPageNum = 3;

  const CustomPageIndicator({required this.currPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPageNum,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 4.8),
          child: Container(
            width: 33,
            height: 3,
            color: index <= currPage ? RibnColors.primary : const Color(0xffB1E7E1),
          ),
        ),
      ),
    );
  }
}
