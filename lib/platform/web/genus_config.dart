import 'package:grpc/grpc_web.dart';

class PlatformGenusConfig {
  static GrpcWebClientChannel channel =
      GrpcWebClientChannel.xhr(Uri.parse('http://35.226.176.100:8099'));
}
