import 'dart:async';
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ribn/providers/packages/http_provider.dart';
import 'package:ribn/services/interfaces/http/i_http_service.dart';

import '../../constants/environment_config.dart';
import '../../models/images/ribn_file_model.dart';

/**
 * @dev File contains implementation of the JIRA service for creating feedback/bug issues
 */
class JiraHTTPService extends HTTPServiceBase {
  final Ref ref;

  JiraHTTPService(this.ref) : super(ref);

  static const Map<String, dynamic> defaultParams = {};
  static Map<String, String> defaultHeaders = {
    'Authorization':
        'Basic ${base64.encode(utf8.encode(EnvironmentConfig.JIRA_EMAIL + ':' + EnvironmentConfig.JIRA_AUTH_TOKEN))}',
    'Content-Type': 'application/json',
  };
  static Map<String, String> defaultHeadersAttachments = {
    'Authorization':
        'Basic ${base64.encode(utf8.encode(EnvironmentConfig.JIRA_EMAIL + ':' + EnvironmentConfig.JIRA_AUTH_TOKEN))}',
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
    ref.read(httpProvider).get(url, headers: headers);
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
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      for (int i = 0; i < files.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('file', files[i].filePath));
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
