import 'dart:async';
import 'dart:typed_data';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class InitializeHDWalletAction {
  final String? keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const InitializeHDWalletAction({this.keyStoreJson, required this.toplExtendedPrivateKey});
}

class GenerateInitialAddressesAction {
  GenerateInitialAddressesAction();
}

class GenerateAddressAction {
  final int accountIndex;
  final int changeIndex;
  final int addressIndex;
  GenerateAddressAction(
    this.addressIndex, {
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
  });
}

class UpdateNetworksWithAddressesAction {
  final Map<String, List<RibnAddress>> networkAddresses;
  const UpdateNetworksWithAddressesAction(this.networkAddresses);
}

class AddAddressAction {
  final String networkName;
  final RibnAddress address;
  const AddAddressAction({required this.networkName, required this.address});
}

class UpdateCurrentNetworkAction {
  String networkName;
  UpdateCurrentNetworkAction(this.networkName);
}

class RefreshBalancesAction {
  final Completer<bool> completer;
  const RefreshBalancesAction(this.completer);
}

class UpdateBalancesAction {
  List<RibnAddress> updatedAddresses;
  UpdateBalancesAction(this.updatedAddresses);
}
