import 'dart:convert';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/models/transaction_history_entry.dart';
import 'package:ribn/presentation/transaction_history/dashed_list_separator.dart';
import 'package:ribn/presentation/transaction_history/transaction_data_row.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_dropdown_title.dart';

class TxHistoryPage extends StatefulWidget {
  final Future<String>? blockHeight;

  const TxHistoryPage({this.blockHeight, Key? key}) : super(key: key);

  @override
  State<TxHistoryPage> createState() => _TxHistoryPageState();
}

class _TxHistoryPageState extends State<TxHistoryPage> {
  List<String> itemsToSelectFrom = ['Sent', 'Received', 'Minted'];

  String filterSelectedItem = 'Transaction types';

  // static List filteredTransactions = AllMovies.where((i) => i.isAnimated).toList();

  void updateSelectedItem(string) {
    setState(() {
      filterSelectedItem = string;
    });
  }

  fetchTxHistory(BuildContext context, ToplAddress toplAddress, int networkId) async {
    final response = await http.get(
      Uri.parse(
        Rules.txHistoryUrl(toplAddress.toBase58(), networkId),
      ),
    );

    // if (filteredTransactions.isEmpty) {
    //   setState(() {
    //     filteredTransactions.add(response.body);
    //   });
    // }

    if (filterSelectedItem != 'Transaction types') {
      print('we have filtered');
      final List filteredTransactions = [];
      filteredTransactions.add(response.body);

      // final filteredTransactions2 = filteredTransactions.where((transaction) => transaction.minting == true).toList();
      // final filteredTransactions2 = filteredTransactions.where((map) => map['minting'] == true).toList();
      // return filteredTransactions.removeWhere((value) => value['minting'] == false);
      // filteredTransactions2 = filteredTransactions.where((map)=>map["tags"].contains(tag)).toList();

      // return filteredTransactions.where((transaction) => transaction['minting'] == false).toList();
      final List data = response.body as List;
      // print(data);
      return data.where((transaction) => transaction['minting'] == false).toList();

      // print(filteredTransactions);
      // final filteredData =
      //     response.body.where((element) => (element['brands'] != null ? element['brands'].contains('Amazon') : false));
    }

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    // if (filterSelectedItem != 'Transaction types') {
    //   print('true this');
    // }
    // print(filteredTransactions);

    return TransactionHistoryContainer(
      builder: (BuildContext context, TransactionHistoryViewmodel vm) => LoaderOverlay(
        overlayColor: Colors.transparent,
        child: Scaffold(
          backgroundColor: RibnColors.background,
          body: RefreshIndicator(
            backgroundColor: RibnColors.primary,
            color: RibnColors.secondaryDark,
            onRefresh: () async {
              await fetchTxHistory(context, vm.toplAddress, vm.networkId);
            },
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    CustomPageDropdownTitle(
                      title: Strings.recentActivity,
                      chevronIconLink: RibnAssets.chevronDown,
                      currentSelectedItem: filterSelectedItem,
                      itemsToSelectFrom: itemsToSelectFrom,
                      updateSelectedItem: updateSelectedItem,
                    ),
                    FutureBuilder(
                      future: fetchTxHistory(context, vm.toplAddress, vm.networkId),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            context.loaderOverlay.hide();

                            if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No transaction history to show'),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 40,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.6),
                                  color: RibnColors.whiteBackground,
                                  border: Border.all(color: RibnColors.lightGrey, width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: RibnColors.greyShadow,
                                      spreadRadius: 0,
                                      blurRadius: 37.5,
                                      offset: Offset(0, -6),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: ListView.separated(
                                    reverse: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    // Here we need to get the length of the filtered array
                                    // itemCount: filterSelectedItem == 'Transaction types'
                                    //     ? snapshot.data?.length
                                    //     : filteredTransactions.length,
                                    itemCount: snapshot.data?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final TransactionHistoryEntry transactionReceipt =
                                          TransactionHistoryEntry.fromJson(snapshot.data[index]);

                                      // Here we need to index the filtered array value

                                      return TransactionDataRow(
                                        transactionReceipt: transactionReceipt,
                                        assets: vm.assets,
                                        myRibnWalletAddress: vm.toplAddress.toBase58(),
                                        blockHeight: vm.blockHeight,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const DashedListSeparator(color: RibnColors.lightGreyDivider);
                                    },
                                  ),
                                ),
                              ),
                            );

                          default:
                            context.loaderOverlay.show();
                            return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
