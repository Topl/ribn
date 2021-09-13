// ignore_for_file: implementation_imports
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class KeyChainState {
  final String? keyStoreJson;
  final HdWallet? hdWallet; // never persisted
  final List<RibnAddress> addresses;

  KeyChainState({
    this.keyStoreJson,
    this.hdWallet,
    this.addresses = const [],
  });

  factory KeyChainState.initial() {
    return KeyChainState();
  }

  int getNextExternalAddressIndex() {
    return addresses.lastWhere((addr) => addr.changeIndex == Rules.defaultChangeIndex).addressIndex + 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'keyStoreJson': keyStoreJson,
      'addresses': addresses.map((x) => x.toMap()).toList(),
    };
  }

  factory KeyChainState.fromMap(Map<String, dynamic> map) {
    return KeyChainState(
      keyStoreJson: map['keyStoreJson'],
      addresses: List<RibnAddress>.from(map['addresses']?.map((x) => RibnAddress.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyChainState.fromJson(String source) => KeyChainState.fromMap(json.decode(source));

  @override
  String toString() =>
      'KeyChainState(keyStoreJson: $keyStoreJson, hdWallet: $hdWallet, addresses: $addresses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeyChainState &&
        other.keyStoreJson == keyStoreJson &&
        other.hdWallet == hdWallet &&
        listEquals(other.addresses, addresses);
  }

  @override
  int get hashCode => keyStoreJson.hashCode ^ hdWallet.hashCode ^ addresses.hashCode;

  KeyChainState copyWith({
    String? keyStoreJson,
    HdWallet? hdWallet,
    List<RibnAddress>? addresses,
  }) {
    return KeyChainState(
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      hdWallet: hdWallet ?? this.hdWallet,
      addresses: addresses ?? this.addresses,
    );
  }
}
