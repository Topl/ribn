import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/presentation/home/mint_page.dart';
import 'package:ribn/presentation/home/wallet_balance_page.dart';
import 'package:ribn/widgets/custom_icon_button.dart';
import 'package:ribn/widgets/ribn_app_bar.dart';

/// The 'home page' of Ribn.
///
/// Builds the [RibnAppBar], [BottomAppBar], and allows navigation to the 3 main pages.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<Widget> _pages = [
    const WalletBalancePage(),
    const MintPage(),
  ];
  final List<SvgPicture> _pageIcons = [
    SvgPicture.asset(RibnAssets.balancePageIcon),
    SvgPicture.asset(RibnAssets.mintPageIcon),
  ];
  final List<SvgPicture> _activePageIcons = [
    SvgPicture.asset(RibnAssets.balancePageActiveIcon),
    SvgPicture.asset(RibnAssets.mintPageActiveIcon),
  ];
  final List<String> _pageLabels = ['HOME', 'MINT'];
  int _currPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RibnAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
      backgroundColor: RibnColors.background,
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
        children: _pages.asMap().keys.map(
          (key) {
            final bool isActive = key == _currPage;
            return CustomIconButton(
              radius: radius,
              height: iconHeight,
              width: iconWidth,
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isActive ? _activePageIcons[key] : _pageIcons[key],
                  Text(
                    _pageLabels[key],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 7,
                      color: isActive ? RibnColors.primary : const Color(0xff979797),
                    ),
                  )
                ],
              ),
              onPressed: () {
                setState(() {
                  _currPage = key;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
