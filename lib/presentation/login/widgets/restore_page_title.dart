import 'package:flutter/material.dart';
import 'package:ribn/widgets/custom_page_title.dart';

/// The page title that is displayed when going through the 'restore wallet' flow.
class RestoreWalletPageTitle extends StatelessWidget {
  const RestoreWalletPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CustomPageTitle(title: 'Restore Wallet'),
          SizedBox(height: 17),
        ],
      ),
    );
  }
}
