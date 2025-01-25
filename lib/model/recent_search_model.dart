class RecentSearchModel {
  String? title = "";
  String? id = "";

  RecentSearchModel(this.id, this.title);

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(json['id'], json['title']);
  }

  @override
  String toString() {
    return '{ $id, $title }';
  }

  Map toJson() => {
        'id': id,
        'title': title,
      };
}
