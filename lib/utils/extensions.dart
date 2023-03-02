import 'package:flutter/cupertino.dart';

extension StringExtensions on String {
  bool toBoolean() {
    return (this.toLowerCase() == "true" || this.toLowerCase() == "1")
        ? true
        : (this.toLowerCase() == "false" || this.toLowerCase() == "0"
            ? false
            : throw UnsupportedError("Cannot convert $this to boolean"));
  }
}

extension NullableStringExtension on String? {
  bool toBooleanWithNullableDefault(bool defaultValue) {
    // define local variable to be eligible for type promotion
    final String? val = this;

    // if not null [val] is promoted to String
    if (val == null) {
      return defaultValue;
    }

    return (val.toLowerCase() == "true" || val.toLowerCase() == "1")
        ? true
        : (val.toLowerCase() == "false" || val.toLowerCase() == "0"
            ? false
            : throw UnsupportedError("Cannot convert $this to boolean"));
  }
}


extension ContextExtensions on BuildContext {
  double get clientWidth => MediaQuery.of(this).size.width;
  double get clientHeight => MediaQuery.of(this).size.height;
}