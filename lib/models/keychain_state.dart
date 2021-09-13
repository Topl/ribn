// ignore_for_file: implementation_imports
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class KeychainState {
  final String? keyStoreJson;
  final HdWallet? hdWallet; // never persisted
  final List<RibnAddress> addresses;

  KeychainState({
    this.keyStoreJson,
    this.hdWallet,
    this.addresses = const [],
  });

  factory KeychainState.initial() {
    return KeychainState();
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

  factory KeychainState.fromMap(Map<String, dynamic> map) {
    return KeychainState(
      keyStoreJson: map['keyStoreJson'],
      addresses: List<RibnAddress>.from(map['addresses']?.map((x) => RibnAddress.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KeychainState.fromJson(String source) => KeychainState.fromMap(json.decode(source));

  @override
  String toString() =>
      'KeychainState(keyStoreJson: $keyStoreJson, hdWallet: $hdWallet, addresses: $addresses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KeychainState &&
        other.keyStoreJson == keyStoreJson &&
        other.hdWallet == hdWallet &&
        listEquals(other.addresses, addresses);
  }

  @override
  int get hashCode => keyStoreJson.hashCode ^ hdWallet.hashCode ^ addresses.hashCode;

  KeychainState copyWith({
    String? keyStoreJson,
    HdWallet? hdWallet,
    List<RibnAddress>? addresses,
  }) {
    return KeychainState(
      keyStoreJson: keyStoreJson ?? this.keyStoreJson,
      hdWallet: hdWallet ?? this.hdWallet,
      addresses: addresses ?? this.addresses,
    );
  }
}
