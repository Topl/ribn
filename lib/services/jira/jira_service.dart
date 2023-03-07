import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ribn/constants/environment_config.dart';
import 'package:ribn/models/images/ribn_file_model.dart';
import 'package:ribn/models/jira/jira_createissue_response_model.dart';
import 'package:ribn/models/jira/jira_issue_model.dart';
import 'package:ribn/services/http/http_service.dart';
import 'package:ribn/services/interfaces/jira/i_jira_service.dart';

class JiraService extends JiraServiceBase {
  final JiraHTTPService _httpService = new JiraHTTPService();
  final String _jiraCreateIssueUrl = EnvironmentConfig.JIRA_CREATE_ISSUE_URL;
  final String _jiraAttachIssueUrl = EnvironmentConfig.JIRA_ATTACH_ISSUE_URL;
  @override
  Future<JiraCreateIssueResponseModel> createJiraIssue(JiraIssueModel model) async {
    final http.Response response = await _httpService.post(_jiraCreateIssueUrl, params: model.toJson());
    print("_jiraCreateIssueUrl: ${response.body}\n${model.toJson()} ");

    JiraCreateIssueResponseModel responseModel = JiraCreateIssueResponseModel.fromJson(json.decode(response.body));
    if (model.fields?.attachments != null) {
      await uploadJiraIssueAttachments(model.fields?.attachments, responseModel.id!);
    }
    responseModel.success = response.statusCode == 201;
    return responseModel;
  }

  @override
  Future<bool> uploadJiraIssueAttachments(List<RibnFileModel>? files, String jiraIssueID) async {
    List<RibnFileModel> tempFiles = files != null ? files : [];
    if (tempFiles.isEmpty) return false;
    final http.Response response = await _httpService.post(_buildAttachIssueURL(jiraIssueID), files: tempFiles);
    return response.statusCode == 200;
  }

  String _buildAttachIssueURL(String issueID) {
    return '${_jiraAttachIssueUrl}${issueID}/attachments';
  }
}
