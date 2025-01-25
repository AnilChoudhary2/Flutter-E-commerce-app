class NotificationModel {
  String? notificationId;
  int? userId;
  String? refId;
  String? description;
  String? createdDate;
  dynamic readAt;
  String? notificationType;

  NotificationModel(
      {this.notificationId,
      this.userId,
      this.refId,
      this.description,
      this.createdDate,
      this.readAt,
      this.notificationType});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    userId = json['userId'];
    refId = json['refId'];
    description = json['description'];
    createdDate = json['createdDate'];
    readAt = json['readAt'];
    notificationType = json['notificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationId'] = notificationId;
    data['userId'] = userId;
    data['refId'] = refId;
    data['description'] = description;
    data['createdDate'] = createdDate;
    data['readAt'] = readAt;
    data['notificationType'] = notificationType;
    return data;
  }
}
