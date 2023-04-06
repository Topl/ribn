// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:crypto/crypto.dart';

extension StringExtensions on String {
  bool toBoolean() {
    return (this.toLowerCase() == "true" || this.toLowerCase() == "1")
        ? true
        : (this.toLowerCase() == "false" || this.toLowerCase() == "0"
            ? false
            : throw UnsupportedError("Cannot convert $this [${this.runtimeType}] to boolean"));
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

  // TODO: Evaluate lifting this functionality to BramblDart to remove direct dependencies on crypto in Ribn
  /// Returns a Hashed representation of the [String] object.
  String toHashSha256() {
    var bytes = utf8.encode(this); // Convert the string to UTF8-encoded bytes
    var digest = sha256.convert(bytes); // Hash the bytes using SHA-256
    return digest.toString(); // Return the hexadecimal representation of the hash
  }
}

extension NullableStringExtension on String? {
  bool toBooleanWithNullableDefault(bool defaultValue) {
    // define local variable to be eligible for type promotion
    final String? val = this;

    // if not null [val] is promoted to String
    if (val == null || val.isEmpty || val == "") {
      return defaultValue;
    }

    return val.toBoolean();
  }

  /// Formats [unit] to only display the first part of the string.
  String formatAssetUnit() {
    return this?.split(' ').first ?? 'Select Unit';
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

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    final list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension dynamicExtensions on dynamic {
  Uint8List toUint8List() {
    return Uint8List.fromList((this as List).cast<int>());
  }
}

extension MapExtensions on Map<String, dynamic> {
  /**
   * Returns a new [Map] with [toAdd] added if [condition] is true.
   */
  Map<String, dynamic> addIf(bool condition, Map<String, dynamic> toAdd) {
    if (!condition) return this;
    return {...this, ...toAdd};
  }
}
