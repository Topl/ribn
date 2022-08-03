import 'dart:convert';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class TxHistorySection extends StatefulWidget {
  const TxHistorySection({Key? key}) : super(key: key);

  @override
  State<TxHistorySection> createState() => _TxHistorySectionState();
}

Future<List<TransactionReceipt>> fetchTxHistory(List<RibnAddress> addresses) async {
  final List<Future<http.Response>> futures = [];
  for (RibnAddress address in addresses) {
    futures.add(
      http.get(
        Uri.parse(
          Rules.txHistoryUrl(address.address.toBase58(), Redux.store!.state.keychainState.currentNetwork.networkId),
        ),
      ),
    );
  }
  final List<http.Response> responses = await Future.wait(futures);
  final List<TransactionReceipt> txHistory = responses
      .map((response) => jsonDecode(response.body) as List)
      .expand((txHistoryList) => txHistoryList)
      .map((tx) {
        final Map<String, dynamic> txReceipt = tx as Map<String, dynamic>;
        txReceipt['timestamp'] = int.parse(txReceipt['timestamp'] as String);
        return txReceipt;
      })
      .map((txReceipt) => TransactionReceipt.fromJson(txReceipt))
      .toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  return txHistory;
}

class _TxHistorySectionState extends State<TxHistorySection> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<RibnAddress>>(
      converter: (store) => store.state.keychainState.currentNetwork.addresses,
      builder: (context, addresses) {
        final bool shouldFetcTxHistory =
            addresses.isNotEmpty && Redux.store!.state.keychainState.currentNetwork.networkId != Rules.privateId;
        return Scaffold(
            appBar: AppBar(),
            body: shouldFetcTxHistory
                ? FutureBuilder(
                    future: fetchTxHistory(addresses),
                    builder: (context, AsyncSnapshot<List<TransactionReceipt>> txHistoryFuture) {
                      switch (txHistoryFuture.connectionState) {
                        case ConnectionState.done:
                          {
                            final int length = txHistoryFuture.data?.length ?? 0;
                            return ListView.separated(
                              separatorBuilder: (context, int idx) => const Divider(),
                              itemCount: length,
                              itemBuilder: (BuildContext context, int idx) {
                                return length == 0
                                    ? const Text('You have no history')
                                    : RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              text: txHistoryFuture.data![idx].id.toString(),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  await launch(
                                                    Rules.txDetailsUrl(
                                                      txHistoryFuture.data![idx].id.toString(),
                                                      Redux.store!.state.keychainState.currentNetwork.networkId,
                                                    ),
                                                  );
                                                },
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            );
                          }
                        default:
                          {
                            return const Text('Loading...');
                          }
                      }
                    },
                  )
                : const Text('No history to fetch'));
      },
    );
  }
}
