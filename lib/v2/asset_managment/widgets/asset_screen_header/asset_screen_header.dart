// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ribn/v2/shared/constants/colors.dart';

class AssetScreenHeader extends StatelessWidget {
  const AssetScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RibnColors.grey,
      child: Center(
        child: Text(
          'Asset Header',
        ),
      ),
    );
  }
}
