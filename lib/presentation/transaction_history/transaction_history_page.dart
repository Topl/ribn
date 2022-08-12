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
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_dropdown_title.dart';

class TxHistoryPage extends StatefulWidget {
  const TxHistoryPage({Key? key}) : super(key: key);

  @override
  State<TxHistoryPage> createState() => _TxHistoryPageState();
}

fetchTxHistory(BuildContext context, ToplAddress toplAddress, int networkId) async {
  final response = await http.get(
    Uri.parse(
      Rules.txHistoryUrl(toplAddress.toBase58(), networkId),
    ),
  );

  return jsonDecode(response.body);
}

class _TxHistoryPageState extends State<TxHistoryPage> {
  static List<String> itemsToSelectFrom = ['Sent', 'Received', 'Minted'];

  static String currentSelectedItem = 'Transaction types';

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

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
                      currentSelectedItem: currentSelectedItem,
                      itemsToSelectFrom: itemsToSelectFrom,
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final TransactionHistoryEntry transactionReceipt =
                                          TransactionHistoryEntry.fromJson(snapshot.data[index]);

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(transactionReceipt.timestamp),
                                                Text('Try htis ish s'),
                                              ],
                                            ),
                                          ],
                                        ),
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
