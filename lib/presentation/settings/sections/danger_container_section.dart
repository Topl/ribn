// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';

/// The section on the settings page that allows user to delete their wallet.
class DangerContainerSection extends StatelessWidget {

  final List<Widget> children;

  const DangerContainerSection({
      required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.dangerZone,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFFE80E00),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          Strings.actionNotReversible,
          style: RibnToolkitTextStyles.settingsSmallText,
        ),
        const SizedBox(height: 10,),
        ...children
      ],
    );
  }
}
