// Package imports:
import 'package:grpc/grpc_web.dart';

// Project imports:
import 'package:ribn/v1/constants/network_utils.dart';

class PlatformGenusConfig {
  static GrpcWebClientChannel channel = GrpcWebClientChannel.xhr(
    // Uri.parse('http://${NetworkUtils.privateIP}:8099'),
    Uri.parse('http://${NetworkUtils.privateIP}:8099'),
  );

  static GrpcWebClientChannel getNetworkConfig(String genusIP) => GrpcWebClientChannel.xhr(
        // Uri.parse('http://${NetworkUtils.privateIP}:8099'),
        Uri.parse('http://$genusIP:8099'),
      );
}
