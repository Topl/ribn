// Project imports:
import 'package:ribn/v1/models/jira/jira_content_model.dart';

class JiraDescriptionModel {
  String? type;
  int? version;
  List<JiraContentModel>? content;

  JiraDescriptionModel({this.type = "doc", this.version = 1, this.content});

  JiraDescriptionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    version = json['version'];
    if (json['content'] != null) {
      content = <JiraContentModel>[];
      json['content'].forEach((v) {
        content!.add(new JiraContentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['version'] = version;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
