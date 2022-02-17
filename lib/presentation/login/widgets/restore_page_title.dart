import 'package:flutter/material.dart';
import 'package:ribn/presentation/login/widgets/page_indicator.dart';
import 'package:ribn/widgets/custom_page_title.dart';

/// The page title, along with the [CustomPageIndicator], that is displayed when going through the 'restore wallet' flow.
class RestoreWalletPageTitle extends StatelessWidget {
  final int currPage;
  const RestoreWalletPageTitle({required this.currPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomPageTitle(title: 'Restore Wallet'),
          const SizedBox(height: 17),
          Center(
            child: CustomPageIndicator(
              currPage: currPage,
            ),
          ),
        ],
      ),
    );
  }
}
