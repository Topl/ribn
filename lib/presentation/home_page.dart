// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/tx_history_page.dart';
import 'package:ribn/presentation/wallet_balance_page.dart';
import 'package:ribn/widgets/ribn_app_bar.dart';

/// Acts as a wrapper widget for the main pages accessible through the [BottomAppBar].
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final WalletBalancePage _walletBalancePage = const WalletBalancePage();
  final TransactionHistoryPage _txHistoryPage = const TransactionHistoryPage();
  late Widget _currPage;

  @override
  void initState() {
    _currPage = _walletBalancePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RibnAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
      body: _currPage,
    );
  }

  /// Builds the [BottomAppBar], allowing navigation to the three main pages.
  /// @TODO: Update icons when selected
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: SvgPicture.asset(RibnAssets.balancePageIcon),
            onPressed: () {
              setState(() {
                _currPage = _walletBalancePage;
              });
              // print(StoreProvider.of<AppState>(context).state.keychainState.hdWallet);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(RibnAssets.txHistoryPageIcon),
            onPressed: () async {
              setState(() {
                _currPage = _txHistoryPage;
              });
              // print(await StoreProvider.of<AppState>(context).state.keychainState.currentNetwork.client!.getNetwork());
            },
          ),
          IconButton(
            icon: SvgPicture.asset(RibnAssets.mintPageIcon),
            onPressed: () {
              // StoreProvider.of<AppState>(context).dispatch(NavigateToRoute(Routes.addresses));
              // StoreProvider.of<AppState>(context).dispatch(AttemptLoginAction(
              //     'Topl1234', StoreProvider.of<AppState>(context).state.keychainState.keyStoreJson!));
            },
          ),
        ],
      ),
    );
  }
}
