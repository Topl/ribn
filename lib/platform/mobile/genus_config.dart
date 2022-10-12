import 'package:grpc/grpc.dart';

class PlatformGenusConfig {
  static ClientChannel channel = ClientChannel(
    '35.226.176.100',
    port: 8089,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
}
