class FaqListModel {
  String? productFaqId;
  User? user;
  String? content;
  int? upvote;
  List<Answers>? answers;
  String? createdDate;
  String? productFaqType;

  FaqListModel(
      {this.productFaqId,
      this.user,
      this.content,
      this.upvote,
      this.answers,
      this.createdDate,
      this.productFaqType});

  FaqListModel.fromJson(Map<String, dynamic> json) {
    productFaqId = json['productFaqId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    content = json['content'];
    upvote = json['upvote'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    productFaqType = json['productFaqType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productFaqId'] = productFaqId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['content'] = content;
    data['upvote'] = upvote;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    data['productFaqType'] = productFaqType;
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

class Answers {
  String? productFaqId;
  User? user;
  String? content;
  int? upvote;
  String? createdDate;
  String? productFaqType;

  Answers(
      {this.productFaqId,
      this.user,
      this.content,
      this.upvote,
      this.createdDate,
      this.productFaqType});

  Answers.fromJson(Map<String, dynamic> json) {
    productFaqId = json['productFaqId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    content = json['content'];
    upvote = json['upvote'];
    createdDate = json['createdDate'];
    productFaqType = json['productFaqType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productFaqId'] = productFaqId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['content'] = content;
    data['upvote'] = upvote;
    data['createdDate'] = createdDate;
    data['productFaqType'] = productFaqType;
    return data;
  }
}
