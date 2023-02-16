

extension StringExtensions on String {
  bool toBoolean() {
    return (this.toLowerCase() == "true" || this.toLowerCase() == "1")
        ? true
        : (this.toLowerCase() == "false" || this.toLowerCase() == "0"
            ? false
            : throw UnsupportedError("Cannot convert $this to boolean"));
  }

  /// Formats an address string to only dispaly its first and last 10 characters.
  String formatAddressString({int charsToDisplay = 10}) {
    const numDots = 3;
    final String dotsString = List<String>.filled(numDots, '.').join();
    final String leftSubstring = this.substring(0, charsToDisplay);
    final String rightSubstring = this.substring(this.length - charsToDisplay);
    return '$leftSubstring$dotsString$rightSubstring';
  }

  String capitalize() => this[0].toUpperCase() + this.substring(1);
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

  /// Formats [unit] to only display the first part of the string.
  String formatAssetUnit() {
    return this?.split(' ').first ?? 'Select Unit';
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    final list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}


