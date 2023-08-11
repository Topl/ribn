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
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: RibnColors.grey,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '0.00',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              'Asset Header',
            ),
          ),
        ],
      ),
    );
  }
}
