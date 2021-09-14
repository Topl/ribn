// ignore_for_file: implementation_imports

import 'package:mubrambl/src/credentials/hd_wallet_helper.dart' as hd;
import 'package:ribn/constants/strings.dart';

class Rules {
  static const int minPasswordLength = 8;
  static const int scryptN = 8192;
  static const int extendedSecretKeySize = 64;
  static const int toplKeyDepth = 2;
  static const int hardenedOffset = hd.hardened_offset;
  // Reference: [CIP-1852](https://github.com/cardano-foundation/CIPs/blob/master/CIP-1852/CIP-1852.md)
  // m / purpose' / coin_type' / account' / role / index
  static const int defaultPurpose = hd.defaultPurpose; // 1852'
  static const int defaultCoinType = hd.defaultCoinType; // 7091'
  static const int defaultAccountIndex = hd.defaultAccountIndex; // 0'
  static const int defaultChangeIndex = hd.defaultChange; // 0=external/payments, 1=internal/change, 2=staking
  static const int defaultAddressIndex = hd.defaultAddressIndex;
  static const int numInitialAddresses = 5;
  static const List<String> settings = [Strings.logout];
  static const int numHomeTabs = 3;
}
