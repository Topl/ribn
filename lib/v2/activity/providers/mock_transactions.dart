import 'dart:math';

import '../models/activity_transaction_state.dart';

List<ActivityTransactionState> getTransactions(n) {
  final DateTime now = DateTime.now();
  final Random random = Random();

  return List.generate(
    n,
    (index) {
      // Generate a random number of days within the past 3 days
      final int randomDaysAgo = random.nextInt(2);
      // Generate a random number of seconds within a day
      final int randomSeconds = random.nextInt(24 * 60 * 60);

      final DateTime randomDate = now.subtract(
        Duration(days: randomDaysAgo, seconds: randomSeconds),
      );

      final randomTransactionType =
          ActivityTransactionType.values[random.nextInt(ActivityTransactionType.values.length)];

      return ActivityTransactionState(
        transactionName: 'Transaction $index',
        transactionDateTime: randomDate,
        transactionSymbol: 'LVL',
        transactionAmount: (random.nextInt(90) + index).toString(),
        transactionAmountInUSD: ((random.nextInt(90) + index) * 10).toString(),
        transactionType: randomTransactionType,
        transactionTypeEnum: randomTransactionType,
      );
    },
  );
}
