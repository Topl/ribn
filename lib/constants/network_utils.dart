// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:brambldart/utils.dart' as constants;

/// Utils and constants that relate to Topl networks.
class NetworkUtils {
  NetworkUtils._();
  static const String toplNet = 'toplnet';
  static const String valhalla = 'valhalla';
  static const String private = 'private';
  static const String privateIP = '104.197.222.150';
  static int toplNetId = constants.networkRegistry[toplNet]!;
  static int valhallaId = constants.networkRegistry[valhalla]!;
  static int privateId = constants.networkRegistry[private]!;
  static Map<int, PolyAmount> networkFees = {
    valhallaId:
        PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.valhallaFee),
    toplNetId:
        PolyAmount.fromUnitAndValue(PolyUnit.nanopoly, constants.toplnetFee),
    privateId: PolyAmount.zero(),
  };
  static const String projectId = '60ff001754b7c75558146daf';
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
}
