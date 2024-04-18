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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
