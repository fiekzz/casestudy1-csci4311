class UserLoginResponseModel {
  String? message;
  Data? data;
  String? date;
  bool? success;

  UserLoginResponseModel({this.message, this.data, this.date, this.success});

  UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    date = json['date'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['date'] = date;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? userId;
  String? token;

  Data({this.userId, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['token'] = token;
    return data;
  }
}
