class GetWorkingStatusModel {
  String? message;
  Data? data;
  bool? success;

  GetWorkingStatusModel({this.message, this.data, this.success});

  GetWorkingStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

enum WorkingStatus {
  NOTSTARTED,
  WORKING,
  FINISHED,
}

class Data {
  WorkingStatus? status;

  Data({this.status});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'] as WorkingStatus;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
