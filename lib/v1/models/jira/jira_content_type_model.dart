class JiraContentTypeModel {
  String? text;
  String? type;

  JiraContentTypeModel({this.text, this.type});

  JiraContentTypeModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['type'] = "text";
    return data;
  }
}
