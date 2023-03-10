import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider.autoDispose<http.Client>((ref) {
  return http.Client();
});
final httpMultipartProvider = Provider<http.MultipartRequest Function()>((ref) {
  return () => http.MultipartRequest("POST", Uri.parse(kUploadFileURL));
});

final httpServiceProvider = Provider<HttpService>((ref) => HttpService(ref.read));
