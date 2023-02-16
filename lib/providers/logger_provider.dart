import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:ribn/constants/loggers.dart';

final loggerPackageProvider = Provider<Logger Function(String)>((ref) {
  return (String loggerClass) => Logger(loggerClass);
});

final loggerProvider = Provider<LoggerNotifier>((ref) {
  return LoggerNotifier(ref);
});

class LoggerNotifier {
  final Ref ref;
  LoggerNotifier(this.ref);

  void logError({
    required LoggerClass loggerClass,
    required String message,
  }) {
    final Logger logger = ref.read(loggerPackageProvider)(loggerClass.string);
    logger.severe(message);
  }
}
