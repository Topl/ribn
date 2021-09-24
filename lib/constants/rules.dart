// ignore_for_file: implementation_imports

import 'package:dio/dio.dart';
import 'package:mubrambl/src/auth/auth.dart';
import 'package:mubrambl/src/core/amount.dart';
import 'package:mubrambl/src/core/client.dart';
import 'package:mubrambl/src/model/balances.dart';
import 'package:ribn/constants/strings.dart';

class Rules {
  static const int minPasswordLength = 8;
  static const int scryptN = 8192;
  static const int extendedSecretKeySize = 64;
  static const int toplKeyDepth = 2;
  static const int hardenedOffset = 0x80000000;
  // Reference: [CIP-1852](https://github.com/cardano-foundation/CIPs/blob/master/CIP-1852/CIP-1852.md)
  // m / purpose' / coin_type' / account' / role / index
  static const int defaultPurpose = 1852 | hardenedOffset; // 1852'
  static const int defaultCoinType = 7091 | hardenedOffset; // 7091'
  static const int defaultAccountIndex = 0 | hardenedOffset; // 0'
  static const int defaultChangeIndex = 0; // 0=external/payments, 1=internal/change, 2=staking
  static const int defaultAddressIndex = 0;
  static const int numInitialAddresses = 5;
  static const List<String> settings = [Strings.logout];
  static const int numHomeTabs = 3;
  static const int toplnetId = 0x01;
  static const int valhallaId = 0x10;
  static const int privateId = 0x40;
  static const Map<int, String> networkStrings = {
    valhallaId: Strings.valhalla,
    toplnetId: Strings.toplnet,
    privateId: Strings.private
  };
  static const String baasApiKey = "Mjc0ODg3MTktYTU3ZS00MGM2LWJkMmMtYTRjMzQxMWY3MjM4";
  static const String projectId = "60ff001754b7c75558146daf";
  static const Map<int, String> networkUrls = {
    valhallaId: "https://staging.vertx.topl.services/valhalla/$projectId",
    toplnetId: "https://staging.vertx.topl.services/valhalla/$projectId", // temporary url
    privateId: "http://localhost:9085"
  };

  static BramblClient getBramblCient(String networkUrl) {
    return BramblClient(
      basePathOverride: networkUrl,
      interceptors: [ApiKeyAuthInterceptor("Mjc0ODg3MTktYTU3ZS00MGM2LWJkMmMtYTRjMzQxMWY3MjM4")],
    );
  }

  static Balance initBalance(String address) {
    return Balance(
      address: address,
      polys: PolyAmount(
        quantity: 0,
        unit: PolyUnit.nanopoly,
      ),
      arbits: ArbitAmount(
        quantity: 0,
        unit: ArbitUnit.nanoarbit,
      ),
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
