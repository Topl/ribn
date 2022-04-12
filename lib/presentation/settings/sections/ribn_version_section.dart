import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';

/// The section for displaying the current Ribn version.
class RibnVersionSection extends StatelessWidget {
  /// The current app version.
  final String appVersion;

  const RibnVersionSection({
    required this.appVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.ribnVersion,
          style: RibnTextStyles.extH3,
        ),
        const SizedBox(height: 10),
        Text(appVersion, style: RibnTextStyles.settingsSmallText),
      ],
    );
  }
}
