// Project imports:
import 'package:ribn/v1/models/jira/jira_fields_model.dart';

class JiraIssueModel {
  JiraFieldsModel? fields;

  JiraIssueModel({this.fields});

  JiraIssueModel.fromJson(Map<String, dynamic> json) {
    fields = json['fields'] != null ? new JiraFieldsModel.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fields != null) {
      data['fields'] = this.fields!.toJson();
    }
    return data;
  }
}
