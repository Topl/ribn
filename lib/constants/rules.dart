// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:brambldart/credentials.dart' as hd;
import 'package:brambldart/utils.dart' as constants;
import 'package:dio/dio.dart';

// Project imports:
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/strings.dart';

class Rules {
  Rules._();
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
  static const int defaultChangeIndex = constants
      .defaultChangeIndex; // 0=external/payments, 1=internal/change, 2=staking
  static const int defaultAddressIndex = constants.defaultAddressIndex;
  static const int assetCodeVersion = constants.supportedAssetCodeVersion;
  static const int internalIdx = 1;
  static Map<int, String> txHistoryUrls = {
    NetworkUtils.valhallaId:
        'https://annulus-api.topl.services/staging/valhalla',
    NetworkUtils.toplNetId: 'https://annulus-api.topl.services/staging/toplnet',
    NetworkUtils.privateId:
        'https://annulus-api.topl.services/staging/valhalla',
  };
  static Map<int, String> txDetailsRedirectUrls = {
    NetworkUtils.valhallaId:
        'https://staging.valhalla.annulus.topl.services/#/transaction/',
    NetworkUtils.toplNetId:
        'https://staging.toplnet.annulus.topl.services/#/transaction/',
    NetworkUtils.privateId:
        'https://staging.valhalla.annulus.topl.services/#/transaction/',
  };
  static String txHistoryUrl(String addr, int networkId) =>
      '${txHistoryUrls[networkId]!}/v1/address/history/$addr';
  static String txDetailsUrl(String txId, int networkId) =>
      '${txDetailsRedirectUrls[networkId]!}$txId';
  static const transferTypes = [
    Strings.polyTransfer,
    Strings.assetTransfer,
    Strings.minting
  ];
  static BramblClient getBramblCient(int networkId) {
    final Dio httpClient = Dio(
      BaseOptions(
        baseUrl: NetworkUtils.networkUrls[networkId]!,
        contentType: 'application/json',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
    return BramblClient(
      httpClient: httpClient,
      interceptors: [
        ApiKeyAuthInterceptor(NetworkUtils.networkApiKeys[networkId]!),
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

enum TransferType {
  polyTransfer,
  assetTransfer,
  mintingAsset,
  remintingAsset,
}

enum AppViews {
  extension, // app opened in the usual extension window
  extensionTab, // extension has a dedicated tab/window open, e.g. during onboarding or dApp interaction
  mobile, // app opened on mobile
  webDebug, // app opened in debug mode on web
}
