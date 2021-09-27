// ignore_for_file: implementation_imports

import 'package:mubrambl/src/credentials/hd_wallet_helper.dart' as hd;
import 'package:mubrambl/src/utils/constants.dart' as constants;
import 'package:mubrambl/src/utils/network.dart';

import 'package:ribn/constants/strings.dart';
import 'package:mubrambl/src/core/client.dart';
import 'package:mubrambl/src/auth/auth.dart';
import 'package:dio/dio.dart';

class Rules {
  static const int minPasswordLength = 8;
  static const int scryptN = 8192;
  static const int extendedSecretKeySize = hd.extended_secret_key_size;
  static const int toplKeyDepth = 2;
  static const int hardenedOffset = constants.HARDENED_OFFSET;
  // Reference: [CIP-1852](https://github.com/cardano-foundation/CIPs/blob/master/CIP-1852/CIP-1852.md)
  // m / purpose' / coin_type' / account' / role / index
  static const int defaultPurpose = constants.DEFAULT_PURPOSE; // 1852'
  static const int defaultCoinType = constants.DEFAULT_COIN_TYPE; // 7091'
  static const int defaultAccountIndex = constants.DEFAULT_ACCOUNT_INDEX; // 0'
  static const int defaultChangeIndex =
      constants.DEFAULT_CHANGE; // 0=external/payments, 1=internal/change, 2=staking
  static const int defaultAddressIndex = constants.DEFAULT_ADDRESS_INDEX;
  static const int numInitialAddresses = 5;
  static const List<String> settings = [Strings.logout];
  static const int numHomeTabs = 3;
  static int toplnetId = NETWORK_REGISTRY[Strings.toplnet]!;
  static int valhallaId = NETWORK_REGISTRY[Strings.valhalla]!;
  static int privateId = NETWORK_REGISTRY[Strings.private]!;
  static Map<int, String> networkStrings = {
    valhallaId: Strings.valhalla,
    toplnetId: Strings.toplnet,
    privateId: Strings.private
  };
  static const String baasApiKey = "Mjc0ODg3MTktYTU3ZS00MGM2LWJkMmMtYTRjMzQxMWY3MjM4";
  static const String projectId = "60ff001754b7c75558146daf";
  static Map<int, String> networkUrls = {
    valhallaId: "https://staging.vertx.topl.services/valhalla/$projectId",
    toplnetId: "https://staging.vertx.topl.services/mainnet/$projectId",
    privateId: "http://localhost:9085"
  };

  static BramblClient getBramblCient(String networkUrl) {
    return BramblClient(
      basePathOverride: networkUrl,
      interceptors: [ApiKeyAuthInterceptor(baasApiKey)],
    );
  }
}

class ApiKeyAuthInterceptor extends AuthInterceptor {
  final String apiKey;

  ApiKeyAuthInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['x-api-key'] = apiKey;
    super.onRequest(options, handler);
  }
}
