// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chains.freezed.dart';

part 'chains.g.dart';

@freezed
sealed class Chains with _$Chains {
  const factory Chains.topl_mainnet({
    @Default('Toplnet') String networkName,
    @Default('mainnet.topl.co') String hostUrl,
    @Default(443) int port,
  }) = ToplMainnet;
  const factory Chains.valhalla_testnet({
    @Default('Valhalla') String networkName,
    @Default('testnet.topl.network') String hostUrl,
    @Default(50051) int port,
  }) = ValhallaTestNet;
  const factory Chains.private_network({
    @Default('Private') String networkName,
    @Default('localhost') String hostUrl,
    @Default(8080) int port,
  }) = PrivateNetwork;
  const factory Chains.dev_network({
    @Default('Development') String networkName,
    @Default('testnet.topl.co') String hostUrl,
    @Default(443) int port,
  }) = DevNetwork;
  const factory Chains.mock({
    @Default('Mock') String networkName,
    @Default('mock') String hostUrl,
    @Default(0000) int port,
  }) = MockNetwork;

  factory Chains.fromJson(Map<String, dynamic> json) => _$ChainsFromJson(json);
}

List<dynamic> splitUrl({required String completeUrl}) {
  // '<route:port>'
  final splitUrl = completeUrl.split(':');

  if (splitUrl.length > 2) {
    throw Exception('Invalid Url');
  }

  var port = int.tryParse(splitUrl[1]);
  if (port == null) {
    throw Exception('Invalid port');
  }

  return [splitUrl[0], port];
}
