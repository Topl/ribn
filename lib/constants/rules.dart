import 'package:brambldart/brambldart.dart';
import 'package:brambldart/credentials.dart' as hd;
import 'package:brambldart/utils.dart' as constants;
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:ribn/constants/strings.dart';

class Rules {
  static const int minPasswordLength = 8;
  static const int scryptN = 8192;
  static const int extendedSecretKeySize = hd.extendedSecretKeySize;
  static const int toplKeyDepth = 2;
  static const int hardenedOffset = constants.hardenedOffset;
  // Reference: [CIP-1852](https://github.com/cardano-foundation/CIPs/blob/master/CIP-1852/CIP-1852.md)
  // m / purpose' / coin_type' / account' / role / index
  static const int defaultPurpose = constants.defaultPurpose; // 1852'
  static const int defaultCoinType = constants.defaultCoinType; // 7091'
  static const int defaultAccountIndex = constants.defaultAccountIndex; // 0'
  static const int defaultChangeIndex =
      constants.defaultChangeIndex; // 0=external/payments, 1=internal/change, 2=staking
  static const int defaultAddressIndex = constants.defaultAddressIndex;
  static const int assetCodeVersion = constants.supportedAssetCodeVersion;
  static const int numInitialAddresses = 5;
  static const int internalIdx = 1;
  static const List<String> settings = [Strings.logout];
  static const int numHomeTabs = 3;
  static int toplnetId = constants.networkRegistry[Strings.toplnet]!;
  static int valhallaId = constants.networkRegistry[Strings.valhalla]!;
  static int privateId = constants.networkRegistry[Strings.private]!;
  static Map<int, String> networkStrings = {
    valhallaId: Strings.valhalla,
    toplnetId: Strings.toplnet,
    privateId: Strings.private
  };
  static const String projectId = '60ff001754b7c75558146daf';
  static Map<int, String> networkApiKeys = {
    valhallaId: 'Mjc0ODg3MTktYTU3ZS00MGM2LWJkMmMtYTRjMzQxMWY3MjM4',
    toplnetId: 'N2IyNDljZmQtZjlkNS00Nzc4LWE1MGQtMmVhMzBjMzIyYjBi',
    privateId: 'topl_the_world!'
  };
  static Map<int, String> networkUrls = {
    // staging.vertx.
    valhallaId: 'https://staging.vertx.topl.services/valhalla/$projectId',
    toplnetId: 'https://staging.vertx.topl.services/mainnet/$projectId',
    privateId: 'http://localhost:9085'
  };
  static Map<int, PolyAmount> networkFees = {
    valhallaId: PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.valhallaFee),
    toplnetId: PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.toplnetFee),
    privateId: PolyAmount.zero(),
  };
  static const transferTypes = [Strings.polyTransfer, Strings.assetTransfer, Strings.minting];
  static const internalMethods = {
    'checkPendingRequest': 'checkPendingRequest',
    'returnResponse': 'returnResponse',
  };
  static BramblClient getBramblCient(int networkId) {
    final Logger logger = Logger('BramblClient');
    final Dio httpClient = Dio(
      BaseOptions(
        baseUrl: networkUrls[networkId]!,
        contentType: 'application/json',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
    return BramblClient(
      httpClient: httpClient,
      interceptors: [
        ApiKeyAuthInterceptor(networkApiKeys[networkId]!),
        RetryInterceptor(
          dio: httpClient,
          logger: logger,
          options: const RetryOptions(retries: 2),
        )
      ],
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
      assets: [],
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
