// import 'dart:convert';

// ignore_for_file: unused_import

import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
// import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/presentation/empty_state_screen.dart';
import 'package:ribn/presentation/transaction_history/dashed_list_separator/dashed_list_separator.dart';
import 'package:ribn/presentation/transaction_history/transaction_data_row/transaction_data_row.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_dropdown_title.dart';

class TxHistoryPage extends StatefulWidget {
  final Future<String>? blockHeight;

  const TxHistoryPage({this.blockHeight, Key? key}) : super(key: key);

  @override
  State<TxHistoryPage> createState() => _TxHistoryPageState();
}

class _TxHistoryPageState extends State<TxHistoryPage> {
  List<String> itemsToSelectFrom = ['Sent', 'Received'];

  String filterSelectedItem = 'Transaction types';

  List filteredTransactions = [];

  void updateSelectedItem(string) {
    setState(() {
      filteredTransactions = [];
      filterSelectedItem = string;
    });
  }

  Future<List<TransactionReceipt>> fetchTxHistory(
    BuildContext context,
    ToplAddress toplAddress,
    int networkId,
    TransactionHistoryViewmodel vm,
  ) async {
    // final List<TransactionReceipt> response = await vm.getTransactions(pageNum: 0);

    //  final tx = TransactionReceipt.fromJson({
    //         'txId': element['txId'],
    //         'from': inputs,
    //         'to': [output],
    //         'txType': element['txType'],
    //         'fee': element['fee'],
    //         'timestamp': int.parse(element['timestamp']),
    //         'boxesToRemove': element['boxesToRemove'] as List,
    //         'newBoxes': newBoxes,
    //         'propositionType': element['propositionType'],
    //       });
    // print(response);

    // print('sd');

    final List<TransactionReceipt> response = [
      TransactionReceipt.fromJson({
        'txId': 'fbU4PH7jXApUPr75skzjGA1VYFSonuQK4A7KztWQCsKi',
        'from': [
          ['3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe', '2394347554651688253'],
        ],
        'to': [
          [
            '3NP1fFfoLxyk8Ac2ByXZnmYTKQ2aH3N9ttgEHZr2otkxC14qA5R9',
            {
              'type': 'Simple',
              'quantity': '10',
            }
          ]
        ],
        'txType': 'PolyTransfer',
        'fee': '100',
        'timestamp': int.parse('1658931096087'),
        'boxesToRemove': [],
        'newBoxes': [],
        'propositionType': 'PublicKeyCurve25519',
        'blockNumber': int.parse('12345'),
        'blockId': 'uSrVWvhZdMs7zVmzs2GENutp5YQybTyo9syEFhMu2b2H',
      }),
      TransactionReceipt.fromJson({
        'txId': 'fbU4PH7jXApUPr75skzjGA1VYFSonuQK4A7KztWQCsKi',
        'from': [
          ['3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe', '2394347554651688253'],
        ],
        'to': [
          [
            '3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe',
            {
              'type': 'Asset',
              'quantity': '10',
              'assetCode': '5YJgVZ47XEEFmGbkuRhYMdwyU92eZhrk84YczAhVBi3dS4jT9KEeQHMDrf',
              'securityRoot': '11111111111111111111111111111111',
              'metadata': ''
            }
          ]
        ],
        'txType': 'AssetTransfer',
        'fee': '100',
        'timestamp': int.parse('1658931096087'),
        'boxesToRemove': [],
        'newBoxes': [],
        'propositionType': 'PublicKeyCurve25519',
        'blockNumber': int.parse('12345'),
        'blockId': 'uSrVWvhZdMs7zVmzs2GENutp5YQybTyo9syEFhMu2b2H',
      })
    ];

    // print(response);

    return response;

    // Add scroll controller to ListView
    // Initstate to add some scolling logic to change page num
    // List<TransactionReceipt>
    // No from JSON needed

    // Here we will add the filtering for sent or received
    // if (filterSelectedItem != 'Transaction types') {
    //   final List transactions = jsonDecode(response.body);

    //   for (var transaction in transactions) {
    //     final transactionReceiverAddress = transaction['to'][0][0].toString();
    //     final transactionSenderAddress = transaction['from'][0][0].toString();
    //     final myRibnAddress = toplAddress.toBase58();
    //     final wasMinted = transaction['minting'] == true;

    //     if (filterSelectedItem == 'Received' && transactionReceiverAddress == myRibnAddress) {
    //       filteredTransactions.add(transaction);
    //     }

    //     if (filterSelectedItem == 'Sent' && transactionSenderAddress == myRibnAddress && !wasMinted) {
    //       filteredTransactions.add(transaction);
    //     }
    //   }

    //   return filteredTransactions;
    // }

    // return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    // const startingFilterValue = 'Transaction types';

    return TransactionHistoryContainer(
      builder: (BuildContext context, TransactionHistoryViewmodel vm) => LoaderOverlay(
        overlayColor: Colors.transparent,
        child: Scaffold(
          backgroundColor: RibnColors.background,
          body: RefreshIndicator(
            backgroundColor: RibnColors.primary,
            color: RibnColors.secondaryDark,
            onRefresh: () async {
              setState(() {});
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
                      future: fetchTxHistory(context, vm.toplAddress, vm.networkId, vm),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            context.loaderOverlay.hide();

                            if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return EmptyStateScreen(
                                icon: RibnAssets.clockWithBorder,
                                title: Strings.noActivityToReview,
                                body: emptyStateBody,
                                buttonOneText: 'Mint',
                                buttonOneAction: () => Keys.navigatorKey.currentState?.pushNamed(
                                  Routes.mintInput,
                                  arguments: {
                                    'mintingNewAsset': true,
                                    'mintingToMyWallet': true,
                                  },
                                ),
                                buttonTwoText: 'Share',
                                buttonTwoAction: () async => await showReceivingAddress(),
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
                                  boxShadow: [
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
                                    // itemCount: filterSelectedItem == startingFilterValue
                                    //     ? snapshot.data?.length
                                    //     : filteredTransactions.length,
                                    itemCount: snapshot.data?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      // Add the filtering back
                                      // final TransactionHistoryEntry transactionReceipt =
                                      //     TransactionHistoryEntry.fromJson(
                                      //   filterSelectedItem == startingFilterValue
                                      //       ? snapshot.data[index]
                                      //       : filteredTransactions[index],
                                      // );

                                      // final TransactionReceipt transactionReceipt =
                                      //     TransactionReceipt.fromJson(snapshot.data[index]);

                                      // print(snapshot.data[index]);

                                      // return Text('transaction');

                                      return TransactionDataRow(
                                        // transactionReceipt: transactionReceipt,
                                        transactionReceipt: snapshot.data[index],
                                        assets: vm.assets,
                                        myRibnWalletAddress: vm.toplAddress.toBase58(),
                                        blockHeight: vm.blockHeight,
                                        networkId: vm.networkId,
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
