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
    print('QQQQ val $val');

    return val.toBoolean();
  }
}

extension ContextExtensions on BuildContext {
  double get clientWidth => MediaQuery.of(this).size.width;

  double get clientHeight => MediaQuery.of(this).size.height;
}

extension IterableWidgetExtension on Iterable<Widget> {
  /**
   * Returns a new lazy [Iterable] with [element] inserted between each element of this [Iterable].
   * uses Generator language feature [https://dart.dev/guides/language/language-tour#generators]
   */
  Iterable<Widget> separator({required Widget element}) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }
}
