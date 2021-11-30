import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/presentation/mint_page.dart';
import 'package:ribn/presentation/tx_history_page.dart';
import 'package:ribn/presentation/wallet_balance_page.dart';
import 'package:ribn/widgets/custom_icon_button.dart';
import 'package:ribn/widgets/ribn_app_bar.dart';

/// Acts as a wrapper widget for the main pages accessible through the [BottomAppBar].
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<Widget> _pages = [
    const WalletBalancePage(),
    const TransactionHistoryPage(),
    const MintPage(),
  ];
  final List<SvgPicture> _pageIcons = [
    SvgPicture.asset(RibnAssets.balancePageIcon),
    SvgPicture.asset(RibnAssets.txHistoryPageIcon),
    SvgPicture.asset(RibnAssets.mintPageIcon),
  ];
  final List<SvgPicture> _activePageIcons = [
    SvgPicture.asset(RibnAssets.balancePageActiveIcon),
    SvgPicture.asset(RibnAssets.txHistoryPageActiveIcon),
    SvgPicture.asset(RibnAssets.mintPageActiveIcon),
  ];
  int _currPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RibnAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
      body: _pages[_currPage],
    );
  }

  /// Builds the [BottomAppBar], allowing navigation to the three main pages.
  Widget _buildBottomAppBar() {
    const double iconHeight = 40;
    const double iconWidth = 40;
    const double radius = 8;
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _pages
            .asMap()
            .keys
            .map(
              (key) => CustomIconButton(
                radius: radius,
                height: iconHeight,
                width: iconWidth,
                icon: key == _currPage ? _activePageIcons[key] : _pageIcons[key],
                onPressed: () {
                  setState(() {
                    _currPage = key;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
