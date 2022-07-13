import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_icon_button.dart';

/// A widget to display the title and back button on top of the page.
///
/// Used during the transfer flows.
class CustomPageTitle extends StatelessWidget {
  const CustomPageTitle({required this.title, this.top = 5, this.left = 10, Key? key}) : super(key: key);
  final String title;
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: left,
          top: top,
          child: CustomIconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
        Center(
          child: Text(
            title,
            style: RibnToolkitTextStyles.extH2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
