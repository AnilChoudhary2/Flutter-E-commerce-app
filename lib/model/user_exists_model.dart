class UserExistsModel {
  bool? userExists;
  bool? registrationRequest;
  bool? phone;
  bool? email;

  UserExistsModel(
      {this.userExists, this.registrationRequest, this.phone, this.email});

  UserExistsModel.fromJson(Map<String, dynamic> json) {
    userExists = json['userExists'];
    registrationRequest = json['registrationRequest'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userExists'] = userExists;
    data['registrationRequest'] = registrationRequest;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
