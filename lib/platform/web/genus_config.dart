import 'package:grpc/grpc_web.dart';

class PlatformGenusConfig {
  static GrpcWebClientChannel channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8099'));
}
