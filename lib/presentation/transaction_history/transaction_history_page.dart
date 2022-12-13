import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:redux/redux.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/helpers/helper_functions.dart';
import 'package:ribn/presentation/empty_state_screen.dart';
import 'package:ribn/presentation/transaction_history/service_locator/locator.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_dropdown_title.dart';
import '../../models/app_state.dart';
import '../../models/ribn_network.dart';
import 'helpers/tx_history_helper_functions.dart';

class TxHistoryPage extends StatefulWidget {
  final Future<String>? blockHeight;

  const TxHistoryPage({this.blockHeight, Key? key}) : super(key: key);

  @override
  State<TxHistoryPage> createState() => _TxHistoryPageState();
}

class _TxHistoryPageState extends State<TxHistoryPage> {
  int _pageNumber = 0;
  String _filterSelectedItem = 'Transaction types';
  List<TransactionReceipt> _allTransactions = <TransactionReceipt>[];
  final _scrollController = ScrollController();
  final List<String> _itemsToSelectFrom = ['All', 'Sent', 'Received'];
  late TransactionHistoryViewmodel _transactionHistoryViewmodel;
  late bool loadedDataBefore = false, _isLoading = true;
  void updateSelectedItem(String selectedItem) {
    setState(() {
      setState(() {
        _isLoading = true;
        _filterSelectedItem = selectedItem;
      });
      fetchTxHistory(
        context,
        _transactionHistoryViewmodel.toplAddress,
        _transactionHistoryViewmodel.networkId,
        _transactionHistoryViewmodel,
      ).then((List<TransactionReceipt> transactions) {
        setState(() {
          _allTransactions = transactions;
          _isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      final Store<AppState> store = locator.get<
          Store<AppState>>(); //@dev Fetch the AppState from the singleton store
      final RibnNetwork currentNetwork =
          store.state.keychainState.currentNetwork;
      _transactionHistoryViewmodel = TransactionHistoryViewmodel(
        toplAddress: currentNetwork.myWalletAddress!.toplAddress,
        networkId: currentNetwork.networkId,
        assets: currentNetwork.getAllAssetsInWallet(),
        blockHeight: currentNetwork.client!.getBlockNumber(),
        getTransactions: ({int pageNum = 0}) async {
          final myWalletAddress =
              currentNetwork.myWalletAddress!.toplAddress.toBase58();
          final mempoolTxs = await TransactionHistoryViewmodel.getMempoolTxs(
            client: currentNetwork.client!,
            walletAddress: myWalletAddress,
          );
          final genusTxs = await TransactionHistoryViewmodel.getGenusTxs(
            walletAddress: myWalletAddress,
          );
          return [...mempoolTxs, ...genusTxs];
        },
      );
      fetchTxHistory(
        ///@dev fetch the transaction history for initial rendering
        context,
        _transactionHistoryViewmodel.toplAddress,
        _transactionHistoryViewmodel.networkId,
        _transactionHistoryViewmodel,
      ).then((List<TransactionReceipt> transactions) {
        setState(() {
          _allTransactions = transactions;
          _isLoading = false;
          loadedDataBefore =
              true; //@dev ensure we not reloading the entire page again but just the next dataset
        });
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        setState(() {
          _isLoading = true; //@dev show overlay
          _pageNumber++;
          fetchTxHistory(
            context,
            _transactionHistoryViewmodel.toplAddress,
            _transactionHistoryViewmodel.networkId,
            _transactionHistoryViewmodel,
          ).then((List<TransactionReceipt> transactions) {
            setState(() {
              _allTransactions = transactions;
              _isLoading = false;
            });
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<TransactionReceipt>> fetchTxHistory(
    BuildContext context,
    ToplAddress toplAddress,
    int networkId,
    TransactionHistoryViewmodel vm,
  ) async {

    final List<TransactionReceipt> response =
        await vm.getTransactions(pageNum: _pageNumber);
    response.unique((transaction) => transaction.id.toString());
    // Filters transactions by sent or received
    if (_filterSelectedItem != 'Transaction types') {
      final List<TransactionReceipt> filteredTransactions =
          <TransactionReceipt>[];
      final List<TransactionReceipt> transactions = response;
      for (TransactionReceipt transaction in transactions) {
        final String transactionReceiverAddress =
            transaction.to.first.toJson()[0].toString();
        final Sender transactionSenderAddress = transaction.from![0];
        final String myRibnAddress = toplAddress.toBase58();
        final bool wasMinted = transaction.minting == true;
        debugPrint('tx: ${transaction.id.toString()}');
        if (_filterSelectedItem == 'Received' &&
            transactionReceiverAddress == myRibnAddress &&
            !wasMinted) {
          debugPrint('Received');
          filteredTransactions.add(transaction);
        } else if (_filterSelectedItem == 'Sent' &&
            transactionSenderAddress.toString() == myRibnAddress.toString() &&
            !wasMinted &&
            transactionReceiverAddress != myRibnAddress) {
          debugPrint('Sent');
          filteredTransactions.add(transaction);
        } else if (_filterSelectedItem == 'All') {
          debugPrint('Other');
          filteredTransactions.add(transaction);
        }
      }
      return filteredTransactions;
    }
    for (var tx in response) {
      debugPrint('tx: ${tx.id.toString()}');
    }
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return TransactionHistoryContainer(
      builder: (BuildContext context, TransactionHistoryViewmodel vm) {
        return LoadingOverlay(
          color: Colors.transparent,
          isLoading: _isLoading,
          child: Scaffold(
            backgroundColor: RibnColors.background,
            body: RefreshIndicator(
              backgroundColor: RibnColors.primary,
              color: RibnColors.secondaryDark,
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                });
                await fetchTxHistory(
                  context,
                  _transactionHistoryViewmodel.toplAddress,
                  _transactionHistoryViewmodel.networkId,
                  _transactionHistoryViewmodel,
                ).then((List<TransactionReceipt> transactions) {
                  setState(() {
                    _allTransactions = transactions;
                    _isLoading = false;
                  });
                });
              },
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: [
                      CustomPageDropdownTitle(
                        title: Strings.recentActivity,
                        chevronIconLink: RibnAssets.chevronDown,
                        currentSelectedItem: _filterSelectedItem,
                        itemsToSelectFrom: _itemsToSelectFrom,
                        updateSelectedItem: updateSelectedItem,
                      ),
                      Padding(
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
                          child: _isLoading && !loadedDataBefore
                              ? EmptyStateScreen(
                                  icon: RibnAssets.clockWithBorder,
                                  title: Strings.noActivityToReview,
                                  body: emptyStateBody,
                                  buttonOneText: 'Mint',
                                  buttonOneAction: () =>
                                      Keys.navigatorKey.currentState?.pushNamed(
                                    Routes.mintInput,
                                    arguments: {
                                      'mintingNewAsset': true,
                                      'mintingToMyWallet': true,
                                    },
                                  ),
                                  buttonTwoText: 'Share',
                                  buttonTwoAction: () async =>
                                      await showReceivingAddress(),
                                  mobileHeight:
                                      MediaQuery.of(context).size.height * 0.63,
                                  desktopHeight: 360,
                                )
                              : _allTransactions.isEmpty
                                  ? EmptyStateScreen(
                                      icon: RibnAssets.clockWithBorder,
                                      title: Strings.noActivityToReview,
                                      body: emptyStateBody,
                                      buttonOneText: 'Mint',
                                      buttonOneAction: () => Keys
                                          .navigatorKey.currentState
                                          ?.pushNamed(
                                        Routes.mintInput,
                                        arguments: {
                                          'mintingNewAsset': true,
                                          'mintingToMyWallet': true,
                                        },
                                      ),
                                      buttonTwoText: 'Share',
                                      buttonTwoAction: () async =>
                                          await showReceivingAddress(),
                                      mobileHeight:
                                          MediaQuery.of(context).size.height *
                                              0.63,
                                      desktopHeight: 360,
                                    )
                                  : loadScrollView(
                                      vm,
                                      _allTransactions,
                                    ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
