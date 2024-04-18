class UserLoginResponseModel {
  String? message;
  Data? data;
  String? date;
  bool? success;

  UserLoginResponseModel({this.message, this.data, this.date, this.success});

  UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    date = json['date'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['date'] = this.date;
    data['success'] = this.success;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
