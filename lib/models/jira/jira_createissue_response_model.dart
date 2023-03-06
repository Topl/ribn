class JiraCreateIssueResponseModel {
  String? id;
  String? key;
  String? self;
  bool success = false;

  JiraCreateIssueResponseModel({this.id, this.key, this.self, this.success = false});

  JiraCreateIssueResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    self = json['self'];
    success = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['self'] = this.self;
    return data;
  }
}
