import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final httpProvider = Provider<http.Request Function()>((ref) {
  return () => http.Request;
});
