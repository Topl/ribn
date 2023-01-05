// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Project imports:
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';

class InitializeHDWalletAction {
  final String? keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const InitializeHDWalletAction(
      {this.keyStoreJson, required this.toplExtendedPrivateKey,});
}

class GenerateInitialAddressesAction {
  GenerateInitialAddressesAction();
}

class GenerateAddressAction {
  final int accountIndex;
  final int changeIndex;
  final int addressIndex;
  final RibnNetwork network;
  GenerateAddressAction(
    this.addressIndex, {
    this.accountIndex = Rules.defaultAccountIndex,
    this.changeIndex = Rules.defaultChangeIndex,
    required this.network,
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
  final RibnNetwork network;
  const RefreshBalancesAction(this.completer, this.network);
}

class UpdateBalancesAction {
  List<RibnAddress> updatedAddresses;
  UpdateBalancesAction(this.updatedAddresses);
}
