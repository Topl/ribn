// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_dropdown_title.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/presentation/empty_state_screen.dart';
import 'package:ribn/presentation/transaction_history/dashed_list_separator/dashed_list_separator.dart';
import 'package:ribn/presentation/transaction_history/transaction_data_row/transaction_data_row.dart';
import 'package:ribn/utils/transaction_utils.dart';
import 'package:ribn/utils/utils.dart';

class TxHistoryPage extends StatefulWidget {
  final Future<String>? blockHeight;

  const TxHistoryPage({this.blockHeight, Key? key}) : super(key: key);

  @override
  State<TxHistoryPage> createState() => _TxHistoryPageState();
}

class _TxHistoryPageState extends State<TxHistoryPage> {
  List<String> itemsToSelectFrom = ['All', 'Sent', 'Received'];

  String filterSelectedItem = 'Transaction types';

  List filteredTransactions = [];

  late bool hasTransactionData = false;

  void updateSelectedItem(string) {
    setState(() {
      filteredTransactions = [];
      filterSelectedItem = string;
    });
  }

  final _scrollController = ScrollController();

  int pageNum = 0;

  String startingFilterValue = 'Transaction types';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          setState(() {
            pageNum += 1;
          });
        }
      }
    });
  }

  Future<List> fetchTxHistory(
    BuildContext context,
    ToplAddress toplAddress,
    int networkId,
    TransactionHistoryViewmodel vm,
  ) async {
    final List<TransactionReceipt> response = filterOutChangeUTxO(await vm.getTransactions(pageNum: pageNum));

    // Filters transactions by sent or received
    if (filterSelectedItem != 'Transaction types') {
      final List<TransactionReceipt> transactions = response;

      for (var transaction in transactions) {
        final String transactionReceiverAddress = transaction.to.first.toJson()[0].toString();
        final Sender transactionSenderAddress = transaction.from![0];
        final myRibnAddress = toplAddress.toBase58();
        final wasMinted = transaction.minting == true;

        if (filterSelectedItem == 'All') {
          filteredTransactions.add(transaction);
        }

        if (filterSelectedItem == 'Received' && transactionReceiverAddress == myRibnAddress && !wasMinted) {
          filteredTransactions.add(transaction);
        }

        if (filterSelectedItem == 'Sent' &&
            transactionSenderAddress.toString() == myRibnAddress.toString() &&
            !wasMinted &&
            transactionReceiverAddress != myRibnAddress) {
          filteredTransactions.add(transaction);
        }
      }

      return filteredTransactions;
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
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
                      future: fetchTxHistory(
                        context,
                        vm.toplAddress,
                        vm.networkId,
                        vm,
                      ),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            context.loaderOverlay.hide();

                            if (!snapshot.hasData || snapshot.data.isEmpty) {
                              return EmptyStateScreen(
                                icon: RibnAssets.clockWithBorder,
                                title: Strings.noActivityToReview,
                                body: emptyStateBody,
                                buttonOneText: 'Share',
                                buttonOneAction: () async => await showReceivingAddress(),
                                mobileHeight: MediaQuery.of(context).size.height * 0.63,
                                desktopHeight: 360,
                              );
                            }

                            var data = [...snapshot.data, ...snapshot.data];

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
                                  border: Border.all(
                                    color: RibnColors.lightGrey,
                                    width: 1,
                                  ),
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
                                    itemCount: filterSelectedItem == startingFilterValue
                                        ? data.length
                                        : filteredTransactions.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final TransactionReceipt transaction = filterSelectedItem == startingFilterValue
                                          ? data[index]
                                          : filteredTransactions[index];

                                      return TransactionDataRow(
                                        transactionReceipt: transaction,
                                        assets: vm.assets,
                                        myRibnWalletAddress: vm.toplAddress.toBase58(),
                                        blockHeight: vm.blockHeight,
                                        networkId: vm.networkId,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const DashedListSeparator(
                                        color: RibnColors.lightGreyDivider,
                                      );
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
