import 'package:flutter/material.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';

/// The section for displaying helpful links.
class LinksSection extends StatelessWidget {
  const LinksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          Strings.links,
          style: RibnTextStyles.extH3,
        ),
        SizedBox(height: 5),
        Text(
          Strings.privacyPolicy,
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.primary,
          ),
        ),
        SizedBox(height: 5),
        Text(
          Strings.termsOfUse,
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: RibnColors.primary,
          ),
        ),
      ],
    );
  }
}
