import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ribn/services/interfaces/http/i_http_service.dart';

import '../../constants/environment_config.dart';
import '../../models/images/ribn_file_model.dart';

/**
 * @dev File contains implementation of the JIRA service for creating feedback/bug issues
 */
class JiraHTTPService extends IHTTPService {
  static const Map<String, dynamic> defaultParams = {};
  static const Map<String, String> defaultHeaders = {
    'Authorization': 'Basic ${EnvironmentConfig.JIRA_AUTH_TOKEN}',
    'Content-Type': 'application/json',
  };
  static const Map<String, String> defaultHeadersAttachments = {
    'Authorization': 'Basic ${EnvironmentConfig.JIRA_AUTH_TOKEN}',
    'Content-Type': 'multipart/form-data',
    'X-Atlassian-Token': 'nocheck',
  };


  static const List<RibnFileModel> defaultFiles = [];

  @override
  Future<http.Response> get(
    String url, {
    Map<String, dynamic> params = defaultParams,
    Map<String, String>? headers,
  }) async {
    headers = defaultHeaders;
    final http.Request request = await http.Request('GET', Uri.parse(url));
    request.body = json.encode(params);
    request.headers.addAll(headers);
    final http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  @override
  Future<http.Response> post(String url,
      {Map<String, dynamic> params = defaultParams,
      Map<String, String>? headers,
      List<RibnFileModel> files = defaultFiles}) async {
    headers = defaultHeaders;
    http.Response response;
    if (files.isNotEmpty) {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(url));
      for (int i = 0; i < files.length; i++) {
        request.files
            .add(await http.MultipartFile.fromPath('file', files[i].filePath));
      }
      request.headers.addAll(defaultHeadersAttachments);
      final http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      final http.Request request = await http.Request('POST', Uri.parse(url));
      request.body = json.encode(params);
      request.headers.addAll(headers);
      final http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }
    return response;
  }
}
