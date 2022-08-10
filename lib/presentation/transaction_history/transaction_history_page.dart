import 'dart:convert';

import 'package:brambldart/brambldart.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/models/transaction_history_entry.dart';
// import 'package:ribn/models/app_state.dart';
// import 'package:ribn/models/ribn_address.dart';
// import 'package:ribn/redux.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:ribn_toolkit/constants/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return TransactionHistoryContainer(
      builder: (BuildContext context, TransactionHistoryViewmodel vm) => LoaderOverlay(
        child: Scaffold(
          backgroundColor: RibnColors.background,
          // appBar: AppBar(),
          body: SingleChildScrollView(
            child: FutureBuilder(
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
          ),
        ),
      ),
    );
  }
}
