class UserTokenModel {
  String? sub;
  String? email;
  List<String>? role;

  UserTokenModel({this.sub, this.email, this.role});

  UserTokenModel.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    email = json['email'];
    role = json['role'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub'] = sub;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
