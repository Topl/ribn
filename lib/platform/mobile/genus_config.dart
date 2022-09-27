import 'package:grpc/grpc.dart';

class PlatformGenusConfig {
  static ClientChannel channel = ClientChannel(
    'localhost',
    port: 8089,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
}
