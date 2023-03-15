// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:brambldart/utils.dart' as constants;

/// Utils and constants that relate to Topl networks.
class NetworkUtils {
  NetworkUtils._();

  static const String projectId = '60ff001754b7c75558146daf';

  // Network names
  static const String toplNet = 'toplnet';
  static const String valhalla = 'valhalla';
  static const String private = 'private';

  // Network IP's
  static const String privateIP = '104.197.222.150';
  static const String valhallaIP = '35.224.14.0';
  static const String toplnetIP = '34.172.5.205';

  // ID's used by RibnNetwork
  static int toplNetId = constants.networkRegistry[toplNet]!;
  static int valhallaId = constants.networkRegistry[valhalla]!;
  static int privateId = constants.networkRegistry[private]!;

  static Map<int, PolyAmount> networkFees = {
    valhallaId: PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.valhallaFee),
    toplNetId: PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.toplnetFee),
    privateId: PolyAmount.zero(),
  };

  static Map<int, String> networkApiKeys = {
    valhallaId: 'Mjc0ODg3MTktYTU3ZS00MGM2LWJkMmMtYTRjMzQxMWY3MjM4',
    toplNetId: 'N2IyNDljZmQtZjlkNS00Nzc4LWE1MGQtMmVhMzBjMzIyYjBi',
    privateId: 'topl_the_world!'
  };

  static Map<int, String> networkUrls = {
    valhallaId: 'https://vertx.topl.services/valhalla/$projectId',
    toplNetId: 'https://vertx.topl.services/mainnet/$projectId',
    privateId: 'http://$privateIP:9085'
  };

  static Map<int, String> genusIPs = {
    valhallaId: valhallaIP,
    // valhallaId: "http:/valhalla.genus.topl.tech",
    toplNetId: toplnetIP,
    // toplNetId: "http://toplnet.genus.topl.tech/",
    privateId: privateIP,
  };

  // http://toplnet.genus.topl.tech/
}

enum Networks {
  valhalla(NetworkUtils.valhalla),
  toplnet(NetworkUtils.toplNet),
  private(NetworkUtils.private);

  const Networks(this.name);

  final String name;
}

class NetworkConfig {
  final String networkName;
  final int networkId;
  final String networkUrl;
  final String genusIP;
  final String apiKey;
  final PolyAmount fee = PolyAmount.zero(); // Leaving as zero as this isn't utilized at the moment

  factory NetworkConfig.fromNetwork(Networks network) {
    final name = network.name;
    final id = constants.networkRegistry[name];
    final url = NetworkUtils.networkApiKeys[id];
    final genusIP = NetworkUtils.genusIPs[id];
    final apiKey = NetworkUtils.networkApiKeys[id] ?? "";

    if (id == null || url == null || genusIP == null) {
      throw Exception("Could not instantiate network config ${network.name}");
    }

    return NetworkConfig(networkName: name, networkId: id, networkUrl: url, genusIP: genusIP, apiKey: apiKey);
  }

  NetworkConfig(
      {required this.networkName,
      required this.networkId,
      required this.networkUrl,
      required this.genusIP,
      this.apiKey = ""});
}
