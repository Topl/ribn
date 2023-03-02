import 'package:ribn/models/jira/jira_project_model.dart';

import '../images/ribn_file_model.dart';
import 'jira_description_model.dart';
import 'jira_issue_assignee_model.dart';

class JiraFieldsModel {
  JiraAssigneeModel? assignee;
  List<String>? labels;
  String? summary;
  JiraAssigneeModel? issuetype;
  JiraProjectModel? project;
  JiraDescriptionModel? description;
  List<RibnFileModel>? attachments;
  JiraFieldsModel(
      {required this.assignee,
      required this.labels,
      required this.summary,
      required this.issuetype,
      required this.project,
      required this.description,
      required this.attachments});

  JiraFieldsModel.fromJson(Map<String, dynamic> json) {
    assignee = json['assignee'] != null
        ? new JiraAssigneeModel.fromJson(json['assignee'])
        : null;
    labels = json['labels'].cast<String>();
    summary = json['summary'];
    issuetype = json['issuetype'] != null
        ? new JiraAssigneeModel.fromJson(json['issuetype'])
        : null;
    project = json['project'] != null
        ? new JiraProjectModel.fromJson(json['project'])
        : null;
    description = json['description'] != null
        ? new JiraDescriptionModel.fromJson(json['description'])
        : null;
    attachments = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignee != null) {
      data['assignee'] = this.assignee!.toJson();
    }
    data['labels'] = this.labels;
    data['summary'] = this.summary;
    if (this.issuetype != null) {
      data['issuetype'] = this.issuetype!.toJson();
    }
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    return data;
  }
}
