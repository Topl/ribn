import 'package:http/http.dart' as http;

import '../../../models/images/ribn_file_model.dart';

/**
 * @dev File contains functions to be used by any client that inherits from it
 * @author brianspha
 */
abstract class HTTPServiceBase {
  Future<http.Response> get(
    String url, {
    Map<String, dynamic> params,
    Map<String, String> headers,
  });
  Future<http.Response> post(String url,
      {Map<String, dynamic> params,
      Map<String, String> headers,
      List<RibnFileModel> files});
}
