// Package imports:
import 'package:grpc/grpc.dart';

// Project imports:
import 'package:ribn/v1/constants/network_utils.dart';

class PlatformGenusConfig {
  static ClientChannel channel = ClientChannel(
    // NetworkUtils.privateIP,
    NetworkUtils.privateIP,
    port: 8089,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  static ClientChannel getNetworkConfig(String genusIP) => ClientChannel(
        genusIP,
        port: 8089,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
}
