enum LoggerClass {
  Transaction('Transaction'),
  ApiError('ApiError'),
  Authentication('Authentication'),
  DApp('dApp');

  const LoggerClass(this.string);
  final String string;
}

enum LogLevel { Info, Warning, Severe, Shout }
