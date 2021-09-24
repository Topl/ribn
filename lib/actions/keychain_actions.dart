// ignore_for_file: implementation_imports

import 'dart:typed_data';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';

class InitializeHDWalletAction {
  final String? keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const InitializeHDWalletAction({this.keyStoreJson, required this.toplExtendedPrivateKey});
}

class GenerateInitialAddressesAction {
  HdWallet? hdWallet;
  GenerateInitialAddressesAction(this.hdWallet);
}

class GenerateAddressAction {
  final int accountIndex;
  final int changeIndex;
  final int addressIndex;
  HdWallet? hdWallet;
  GenerateAddressAction(
    this.addressIndex,
    this.hdWallet, {
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
  });
}

class AddAddressesAction {
  final List<RibnAddress> addresses;
  const AddAddressesAction({this.addresses = const []});
}

class UpdateCurrentNetworkAction {
  String networkId;
  UpdateCurrentNetworkAction(this.networkId);
}

class RefreshBalancesAction {}

class UpdateBalancesAction {
  List<RibnAddress> updatedAddresses;
  UpdateBalancesAction(this.updatedAddresses);
}

class BalancesLoadingAction {}
