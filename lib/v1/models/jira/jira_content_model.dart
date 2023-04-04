// Project imports:
import 'package:ribn/v1/models/jira/jira_content_type_model.dart';

class JiraContentModel {
  String? type;
  List<JiraContentTypeModel>? content;

  JiraContentModel({this.type = "paragraph", this.content});

  JiraContentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['content'] != null) {
      content = <JiraContentTypeModel>[];
      json['content'].forEach((v) {
        content!.add(new JiraContentTypeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
