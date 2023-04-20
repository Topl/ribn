// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

// Project imports:
import 'package:ribn/v2/core/constants/loggers.dart';

export 'package:ribn/v2/core/constants/loggers.dart'; // export so dependent files can use the enums

final loggerPackageProvider = Provider<Logger Function(String)>((ref) {
  return (String loggerClass) => Logger(loggerClass);
});

final loggerProvider = Provider<LoggerNotifier>((ref) {
  return LoggerNotifier(ref);
});

class LoggerNotifier {
  final Ref ref;

  LoggerNotifier(this.ref) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  void log({
    required LogLevel logLevel,
    required LoggerClass loggerClass,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final Logger logger = ref.read(loggerPackageProvider)(loggerClass.string);
    switch (logLevel) {
      case LogLevel.Info:
        logger.info(message, error, stackTrace);
        break;
      case LogLevel.Warning:
        logger.warning(message, error, stackTrace);
        break;
      case LogLevel.Severe:
        logger.severe(message, error, stackTrace);
        break;
      case LogLevel.Shout:
        logger.shout(message, error, stackTrace);
        break;
    }
  }
}
