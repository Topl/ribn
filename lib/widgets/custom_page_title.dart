import 'package:flutter/material.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/custom_icon_button.dart';

/// A widget to display the title and back button on top of the page.
///
/// Used during the transfer flows.
class CustomPageTitle extends StatelessWidget {
  const CustomPageTitle({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 5,
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
            style: RibnTextStyles.extH2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
