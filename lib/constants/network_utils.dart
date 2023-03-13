// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:brambldart/utils.dart' as constants;


enum Networks {
  valhalla("valhalla"),
  toplnet("toplnet"),
  private("private");

  const Networks(this.name);

  final String name;
}


/// Utils and constants that relate to Topl networks.
class NetworkUtils {
  NetworkUtils._();

  static const String projectId = '60ff001754b7c75558146daf';


  static const String toplNet = 'toplnet';
  static const String valhalla = 'valhalla';
  static const String private = 'private';
  static const String privateIP = '104.197.222.150';
  static const String valhallaIP = '34.72.160.177';
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
    privateId: 'http://104.197.222.150:9085'
  };

  static Map<int, String> genusIPs = {
    // valhallaId: "34.72.160.177",
    valhallaId: "35.224.14.0",
    // valhallaId: "http:/valhalla.genus.topl.tech",
    toplNetId: "34.171.109.202",
    // toplNetId: "http://toplnet.genus.topl.tech/",
    privateId: "104.197.222.150"
  };

  // http://toplnet.genus.topl.tech/
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
