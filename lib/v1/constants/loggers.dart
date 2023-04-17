enum LoggerClass {
  Transaction('Transaction'),
  ApiError('ApiError'),
  Analytics('Analytics'),
  Authentication('Authentication');

  const LoggerClass(this.string);
  final String string;
}

enum LogLevel { Info, Warning, Severe, Shout }
