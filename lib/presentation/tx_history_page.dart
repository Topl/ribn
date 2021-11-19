import 'package:flutter/material.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/address_section.dart';
import 'package:ribn/presentation/transaction_section.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: Rules.numHomeTabs, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              const Text("First page"),
              const TransactionSection(),
              AddressSection(),
            ],
          ),
        ),
        // Expanded(
        //   child: TabBarView(
        //     physics: const NeverScrollableScrollPhysics(),
        //     controller: _tabController,
        //     children: [
        //       Text("First page"),
        //       const TransactionSection(),
        //       AddressSection(),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      automaticIndicatorColorAdjustment: true,
      tabs: const [
        Tab(child: Text(Strings.assets)),
        Tab(child: Text(Strings.send)),
        Tab(child: Text(Strings.receive)),
      ],
    );
  }
}
