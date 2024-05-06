class GetAllStaffModel {
  String? message;
  List<Data>? data;
  bool? success;

  GetAllStaffModel({this.message, this.data, this.success});

  GetAllStaffModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? userID;
  String? fullName;
  String? email;
  List<Roles>? roles;
  List<PaymentByWeek>? paymentByWeek;
  List<Attendance>? attendance;

  Data(
      {this.userID,
      this.fullName,
      this.email,
      this.roles,
      this.paymentByWeek,
      this.attendance});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    fullName = json['fullName'];
    email = json['email'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    if (json['PaymentByWeek'] != null) {
      paymentByWeek = <PaymentByWeek>[];
      json['PaymentByWeek'].forEach((v) {
        paymentByWeek!.add(new PaymentByWeek.fromJson(v));
      });
    }
    if (json['Attendance'] != null) {
      attendance = <Attendance>[];
      json['Attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.paymentByWeek != null) {
      data['PaymentByWeek'] =
          this.paymentByWeek!.map((v) => v.toJson()).toList();
    }
    if (this.attendance != null) {
      data['Attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  String? roleID;
  String? roleName;
  int? rate;

  Roles({this.roleID, this.roleName, this.rate});

  Roles.fromJson(Map<String, dynamic> json) {
    roleID = json['roleID'];
    roleName = json['roleName'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleID'] = this.roleID;
    data['roleName'] = this.roleName;
    data['rate'] = this.rate;
    return data;
  }
}

class PaymentByWeek {
  String? paymentID;
  String? userID;
  String? startDateOfTheWeek;
  int? amount;
  int? totalHours;

  PaymentByWeek(
      {this.paymentID,
      this.userID,
      this.startDateOfTheWeek,
      this.amount,
      this.totalHours});

  PaymentByWeek.fromJson(Map<String, dynamic> json) {
    paymentID = json['paymentID'];
    userID = json['userID'];
    startDateOfTheWeek = json['startDateOfTheWeek'];
    amount = json['amount'];
    totalHours = int.tryParse(json['totalHours'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentID'] = this.paymentID;
    data['userID'] = this.userID;
    data['startDateOfTheWeek'] = this.startDateOfTheWeek;
    data['amount'] = this.amount;
    data['totalHours'] = this.totalHours;
    return data;
  }
}

class Attendance {
  String? attendanceID;
  String? userID;
  String? checkIn;
  String? checkOut;

  Attendance({this.attendanceID, this.userID, this.checkIn, this.checkOut});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendanceID = json['attendanceID'];
    userID = json['userID'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendanceID'] = this.attendanceID;
    data['userID'] = this.userID;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    return data;
  }
}
