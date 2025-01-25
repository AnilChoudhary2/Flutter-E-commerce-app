class HomeBannersModel {
  int? advertId;
  String? advertType;
  bool? isPublic;
  String? url;

  HomeBannersModel({this.advertId, this.advertType, this.isPublic, this.url});

  HomeBannersModel.fromJson(Map<String, dynamic> json) {
    advertId = json['advertId'];
    advertType = json['advertType'];
    isPublic = json['isPublic'];
    url = json['url'];
  }
}
