// Package imports:
import 'package:brambldart/credentials.dart';
// Project imports:
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/ribn_address.dart';

Map<String, dynamic> testData = {
  'mnemonic':
      'napkin they pupil disorder junior tonight harsh mobile equal explain allow fancy',
  'rootExtendedPrvKey':
      '64, 152, 147, 162, 27, 218, 199, 183, 63, 203, 225, 8, 66, 19, 70, 136, 195, 167, 2, 80, 205, 2, 101, 184, 123, 4, 1, 243, 211, 71, 151, 94, 55, 233, 205, 8, 240, 57, 245, 113, 25, 135, 174, 17, 19, 89, 46, 188, 137, 86, 233, 16, 223, 41, 177, 217, 128, 221, 55, 128, 147, 74, 229, 221, 235, 233, 231, 45, 1, 34, 13, 37, 45, 17, 170, 166, 208, 154, 59, 17, 179, 13, 219, 191, 21, 64, 115, 19, 223, 133, 72, 255, 45, 171, 47, 108',
  'toplExtendedPrvKey':
      '8, 144, 221, 238, 230, 133, 6, 98, 20, 196, 217, 238, 161, 34, 54, 33, 144, 202, 237, 234, 251, 182, 163, 220, 126, 81, 225, 156, 221, 71, 151, 94, 216, 81, 219, 143, 30, 79, 28, 147, 154, 64, 157, 82, 63, 18, 229, 14, 13, 44, 39, 50, 125, 144, 103, 37, 41, 214, 95, 129, 63, 191, 249, 70, 4, 10, 134, 193, 196, 99, 235, 30, 98, 38, 134, 234, 227, 159, 180, 209, 100, 205, 223, 78, 219, 90, 37, 1, 52, 247, 173, 34, 33, 173, 169, 176',
  'keyStoreJson':
      '{"crypto":{"cipher":"aes-256-ctr","cipherParams":{"iv":"qrcRovTWJywPpVe7AWiCd"},"cipherText":"4cr6msiqFkGUH3oAwjGeVheJtZ6HDYR19Wjh2giA2QhGfZP3EsnsotdYppWwTvsmviaTKuy71tcc3LRy2Rzo9uzxdpt2jfQQS8a7JSFHSGotvvnjzghrrBJTctJiwcpzz16","kdf":"scrypt","kdfparams":{"dkLen":32,"n":4,"r":8,"p":1,"salt":"5cVdc7AbAYQNWDEWZQyMNvAEG3psb76cPVqvQWU69RPS"},"mac":"8pPeSSuqXJZmzVY9uV4GwhzS9GPEt67btnAHh9jfTgVg"},"id":"d968c738-297c-4798-b68d-2e0a25c6de81","version":1}',
  'validPassword': '12345678',
  'invalidPassword': '1234567',
  'address': RibnAddress(
    toplAddress: ToplAddress.fromBase58(
      'AUDxRxPtWPeejAMfEeYMYfwQ7Shk5qLw4swZkW6sek3D4FMDrQ6D',
    ),
    addressIndex: 0,
    keyPath: '',
    balance: Rules.initBalance(
      'AUDxRxPtWPeejAMfEeYMYfwQ7Shk5qLw4swZkW6sek3D4FMDrQ6D',
    ),
    networkId: NetworkUtils.privateId,
  ),
};

List<int> toList(String csv) => csv.split(',').map(int.parse).toList();
