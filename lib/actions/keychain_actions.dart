import 'dart:typed_data';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

class InitializeHDWalletAction {
  final String? keyStoreJson;
  final Uint8List toplExtendedPrivateKey;
  const InitializeHDWalletAction({this.keyStoreJson, required this.toplExtendedPrivateKey});
}

class GenerateInitialAddressesAction {}

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

class AddAddressesAction {
  final List<RibnAddress> addresses;
  const AddAddressesAction({this.addresses = const []});
}
