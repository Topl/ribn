import 'package:grpc/grpc.dart';
import 'package:ribn/constants/network_utils.dart';

class PlatformGenusConfig {
  static ClientChannel channel = ClientChannel(
    NetworkUtils.privateIP,
    port: 8089,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
}
