// Flutter imports:
// Package imports:
import 'package:brambldart/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:ribn_toolkit/constants/colors.dart';

// Project imports:
import '../../../containers/transaction_history_container.dart';
import '../dashed_list_separator/dashed_list_separator.dart';
import '../transaction_data_row/transaction_data_row.dart';

Widget loadScrollView(
  TransactionHistoryViewmodel transactionHistoryViewmodel,
  List<TransactionReceipt> transactions,
) {
  return ListView.separated(
    reverse: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: transactions.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final TransactionReceipt transaction = transactions[index];
      return TransactionDataRow(
        transactionReceipt: transaction,
        assets: transactionHistoryViewmodel.assets,
        myRibnWalletAddress: transactionHistoryViewmodel.toplAddress.toBase58(),
        blockHeight: transactionHistoryViewmodel.blockHeight,
        networkId: transactionHistoryViewmodel.networkId,
      );
    },
    separatorBuilder: (context, index) {
      return const DashedListSeparator(color: RibnColors.lightGreyDivider);
    },
  );
}
