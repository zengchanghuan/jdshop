// FocusModel.fromJson(json);
class FocusModel {
  List<FocusItemModel> result = [];

  FocusModel({required this.result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(FocusItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.map((v) => v.toJson()).toList();
    return data;
  }
}

class FocusItemModel {
  String sId = "";
  String title = "";
  String status = "";
  String pic = "";
  String url = "";

  FocusItemModel({required this.sId,required this.title, required this.status,required this.pic,required this.url});

  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}
