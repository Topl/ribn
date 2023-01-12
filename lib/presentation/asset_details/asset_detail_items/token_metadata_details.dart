// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/styles.dart';

// Project imports:

import 'package:ribn/utils.dart';

/// One of the asset details displayed on [AssetDetailsPage].
///
/// Displays the asset code, a tooltip with more description, and a copy button.
class TokenMetadataDetails extends StatelessWidget {
  /// The asset code to be displayed.
  final String tokenMetadata;
  const TokenMetadataDetails({
    Key? key,
    required this.tokenMetadata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Token Metadata', style: RibnToolkitTextStyles.h4),
        const SizedBox(height: 3),
        Text(
          tokenMetadata,
          style: RibnToolkitTextStyles.smallBody,
        ),
      ],
    );
  }
}
