enum LoggerClass {
  transaction('transaction'),
  apiError('apiError');

  const LoggerClass(this.string);
  final String string;
}
