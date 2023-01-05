// Package imports:
import 'package:grpc/grpc_web.dart';

// Project imports:
import 'package:ribn/constants/network_utils.dart';

class PlatformGenusConfig {
  static GrpcWebClientChannel channel = GrpcWebClientChannel.xhr(
      Uri.parse('http://${NetworkUtils.privateIP}:8099'),);
}
