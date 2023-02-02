import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:ribn/constants/loggers.dart';

final loggerProvider =
    Provider<Logger Function(String)>((ref) => (String loggerName) => Logger(loggerName));

final Logger Function() transactionLogger = () {
  // Allows to get riverpod state without ref
  final container = ProviderContainer();

  return container.read(loggerProvider)(kTransactionLogger);
};
