class ReviewListModel {
  String? reviewId;
  User? user;
  int? rating;
  String? description;
  int? upvote;
  String? createdDate;
  List<String>? images;

  ReviewListModel(
      {this.reviewId,
      this.user,
      this.rating,
      this.description,
      this.upvote,
      this.createdDate,
      this.images});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'];
    description = json['description'];
    upvote = json['upvote'];
    createdDate = json['createdDate'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewId'] = reviewId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['description'] = description;
    data['upvote'] = upvote;
    data['createdDate'] = createdDate;
    data['images'] = images;
    return data;
  }
}

class User {
  int? userId;
  String? email;
  String? phone;
  bool? isTwoFactorEnabled;
  bool? isActive;
  String? displayName;
  String? avatarUrl;
  String? createdDate;
  String? updatedDate;

  User(
      {this.userId,
      this.email,
      this.phone,
      this.isTwoFactorEnabled,
      this.isActive,
      this.displayName,
      this.avatarUrl,
      this.createdDate,
      this.updatedDate});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    phone = json['phone'];
    isTwoFactorEnabled = json['isTwoFactorEnabled'];
    isActive = json['isActive'];
    displayName = json['displayName'];
    avatarUrl = json['avatarUrl'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['phone'] = phone;
    data['isTwoFactorEnabled'] = isTwoFactorEnabled;
    data['isActive'] = isActive;
    data['displayName'] = displayName;
    data['avatarUrl'] = avatarUrl;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
