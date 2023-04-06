// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

class InternalMessage {
  final String method;
  final Map<String, dynamic>? data;
  final String target;
  final String sender;
  final String id;
  final String origin;
  InternalMessage({
    required this.method,
    this.data,
    required this.target,
    this.sender = defaultSender,
    required this.id,
    required this.origin,
  });

  InternalMessage copyWith({
    String? method,
    Map<String, dynamic>? data,
    String? target,
    String? sender,
    String? id,
    String? origin,
  }) {
    return InternalMessage(
      method: method ?? this.method,
      data: data ?? this.data,
      target: target ?? this.target,
      sender: sender ?? this.sender,
      id: id ?? this.id,
      origin: origin ?? this.origin,
    );
  }

  static const String defaultSender = 'ribn';

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'data': data,
      'target': target,
      'sender': sender,
      'id': id,
      'origin': origin,
    };
  }

  factory InternalMessage.fromMap(Map<String, dynamic> map) {
    return InternalMessage(
      method: map['method'] as String,
      data: map['data'] != null ? Map<String, dynamic>.from(map['data'] as Map<String, dynamic>) : null,
      target: map['target'] as String,
      sender: map['sender'] as String,
      id: map['id'] as String,
      origin: map['origin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InternalMessage.fromJson(String source) =>
      InternalMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InternalMessage(method: $method, data: $data, target: $target, sender: $sender, id: $id, origin: $origin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InternalMessage &&
        other.method == method &&
        mapEquals(other.data, data) &&
        other.target == target &&
        other.sender == sender &&
        other.id == id &&
        other.origin == origin;
  }

  @override
  int get hashCode {
    return method.hashCode ^ data.hashCode ^ target.hashCode ^ sender.hashCode ^ id.hashCode ^ origin.hashCode;
  }
}

/// A helper class to access methods used in [InternalMessage]s between the popup and background script.
class InternalMethods {
  InternalMethods._();

  /// Used to check if there is a pending request in the background script, e.g. originating form a dApp.
  static String get checkPendingRequest => 'checkPendingRequest';

  /// Used to return a response from the popup to the background script.
  static String get returnResponse => 'returnResponse';

  /// Used to enable/allowlist urls.
  static String get enable => 'enable';

  /// Used to sign tx through Ribn.
  static String get signTx => 'signTx';

  /// Used to obtain wallet balance through Ribn.
  static String get getBalance => 'getBalance';

  /// Used to obtain wallet balance through Ribn.
  static String get authorize => 'authorize';

  /// Used to obtain wallet balance through Ribn.
  static String get signTransaction => 'signTransaction';

  /// Used to obtain wallet balance through Ribn.
  static String get clearList => 'clearList';
}
