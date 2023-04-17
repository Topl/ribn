// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';

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
          style: RibnToolkitTextStyles.extH3,
        ),
        const SizedBox(height: 10),
        Text(appVersion, style: RibnToolkitTextStyles.settingsSmallText),
      ],
    );
  }
}
