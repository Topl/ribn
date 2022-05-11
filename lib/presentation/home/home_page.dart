import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/presentation/home/mint_page.dart';
import 'package:ribn/presentation/home/wallet_balance_page.dart';
import 'package:ribn/widgets/ribn_app_bar_wapper.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/ribn_bottom_app_bar.dart';

/// The 'home page' of Ribn.
///
/// Builds the [RibnAppBar], [BottomAppBar], and allows navigation to the 3 main pages.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<dynamic> _pages = [
    const WalletBalancePage(),
    const MintPage(),
  ];
  final List<Image> _pageIcons = [
    Image.asset(RibnAssets.walletGrey),
    Image.asset(RibnAssets.plusGrey),
  ];
  final List<Image> _activePageIcons = [
    Image.asset(RibnAssets.walletBlue),
    Image.asset(RibnAssets.plusBlue),
  ];
  int _currPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RibnAppBarWrapper(),
      bottomNavigationBar: RibnBottomAppBar(
        pages: _pages,
        currPage: _currPage,
        activePageIcons: _activePageIcons,
        pageIcons: _pageIcons,
        setCurrentPage: setCurrentPage,
      ),
      backgroundColor: RibnColors.background,
      body: _pages[_currPage],
    );
  }

  void setCurrentPage(key) {
    setState(() {
      _currPage = key;
    });
  }
}
