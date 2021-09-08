import 'dart:convert';

import 'package:bip_topl/bip_topl.dart';

class KeyChainState {
  final String? keyStoreJson;
  final Cip1852KeyTree? cip1852keyTree; // never persisted

  KeyChainState({
    this.keyStoreJson,
    this.cip1852keyTree,
  });

  factory KeyChainState.initial() {
    return KeyChainState();
  }

  Map<String, dynamic> toMap() {
    return {
      'keyStoreJson': keyStoreJson,
    };
  }

  factory KeyChainState.fromMap(Map<String, dynamic> map) {
    return KeyChainState(
      keyStoreJson: map['keyStoreJson'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyChainState.fromJson(String source) => KeyChainState.fromMap(json.decode(source));

  @override
  String toString() => 'KeyChainState(keyStoreJson: $keyStoreJson, cip1852keyTree: $cip1852keyTree)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeyChainState &&
        other.keyStoreJson == keyStoreJson &&
        other.cip1852keyTree == cip1852keyTree;
  }

  @override
  int get hashCode => keyStoreJson.hashCode ^ cip1852keyTree.hashCode;

  KeyChainState copyWith({
    String? keyStoreJson,
    Cip1852KeyTree? cip1852keyTree,
  }) {
    return KeyChainState(
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      cip1852keyTree: cip1852keyTree ?? this.cip1852keyTree,
    );
  }
}
