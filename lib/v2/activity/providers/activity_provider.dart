import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/activity/providers/mock_transactions.dart';

import '../models/activity_transaction_state.dart';

final activityProvider =
    StateNotifierProvider<ActivityNotifier, AsyncValue<Map<String, List<ActivityTransactionState>>>>((ref) {
  return ActivityNotifier();
});

class ActivityNotifier extends StateNotifier<AsyncValue<Map<String, List<ActivityTransactionState>>>> {
  ActivityNotifier() : super(AsyncLoading()) {
    getActivities();
  }

  Future<Map<String, List<ActivityTransactionState>>> getActivities() {
    final List<ActivityTransactionState> mockTransactions = getTransactions(10);
    final Map<String, List<ActivityTransactionState>> groupedTransactions = groupBy(
        mockTransactions,
        (ActivityTransactionState transaction) =>
            DateFormat('MM/dd/yyyy').format(transaction.transactionDateTime).toString());

    // Sort the grouped transactions by date
    final sortedGroupedData = new SplayTreeMap<String, List<ActivityTransactionState>>.from(
        groupedTransactions, (a, b) => DateFormat('MM/dd/yyyy').parse(b).compareTo(DateFormat('MM/dd/yyyy').parse(a)));
    state = AsyncData(sortedGroupedData);
    return Future.value(sortedGroupedData);
  }

  Future<List<ActivityTransactionState>> refreshActivities() {
    // TODO: implement refreshActivities
    throw UnimplementedError();
  }

  Stream<List<ActivityTransactionState>> streamActivities() {
    // TODO: implement streamActivities
    throw UnimplementedError();
  }
}
