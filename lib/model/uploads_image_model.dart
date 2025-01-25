class UploadsImageModel {
  List<String>? paths;

  UploadsImageModel({this.paths});

  UploadsImageModel.fromJson(Map<String, dynamic> json) {
    paths = json['paths'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paths'] = paths;
    return data;
  }
}
