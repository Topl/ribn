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
          body: SingleChildScrollView(
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
                        return Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final TransactionHistoryEntry transactionReceipt =
                                  TransactionHistoryEntry.fromJson(snapshot.data[index]);

                              return Text(transactionReceipt.timestamp);
                            },
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
    );
  }
}
