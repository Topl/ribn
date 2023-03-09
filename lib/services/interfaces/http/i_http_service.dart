import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../models/images/ribn_file_model.dart';

/**
 * @dev File contains functions to be used by any client that inherits from it
 * @author brianspha
 */
abstract class HTTPServiceBase {
  final Ref ref;

  HTTPServiceBase(this.ref);
  Future<http.Response> get(
    String url, {
    Map<String, dynamic> params,
    Map<String, String> headers,
  }) {}

  Future<http.Response> post(String url,
      {Map<String, dynamic> params, Map<String, String> headers, List<RibnFileModel> files});
}
