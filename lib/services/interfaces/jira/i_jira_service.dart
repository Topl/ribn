import 'package:ribn/models/images/ribn_file_model.dart';
import 'package:ribn/models/jira/jira_issue_model.dart';

import '../../../models/jira/jira_createissue_response_model.dart';

abstract class JiraServiceBase {
  Future<JiraCreateIssueResponseModel> createJiraIssue(JiraIssueModel model);
  Future<bool> uploadJiraIssueAttachments(List<RibnFileModel> files, String jiraIssueID);
}
