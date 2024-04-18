class GetUserDetailsModel {
  String? message;
  Data? data;
  List<UserWorkingTime>? userWorkingTime;
  int? totalHoursPerMonth;
  int? thisMonthRevenue;
  int? overallRevenue;
  bool? success;

  GetUserDetailsModel(
      {this.message,
      this.data,
      this.userWorkingTime,
      this.totalHoursPerMonth,
      this.thisMonthRevenue,
      this.overallRevenue,
      this.success});

  GetUserDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['userWorkingTime'] != null) {
      userWorkingTime = <UserWorkingTime>[];
      json['userWorkingTime'].forEach((v) {
        userWorkingTime!.add(new UserWorkingTime.fromJson(v));
      });
    }
    totalHoursPerMonth = json['totalHoursPerMonth'];
    thisMonthRevenue = json['thisMonthRevenue'];
    overallRevenue = json['overallRevenue'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.userWorkingTime != null) {
      data['userWorkingTime'] =
          this.userWorkingTime!.map((v) => v.toJson()).toList();
    }
    data['totalHoursPerMonth'] = this.totalHoursPerMonth;
    data['thisMonthRevenue'] = this.thisMonthRevenue;
    data['overallRevenue'] = this.overallRevenue;
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
  int? amount;
  String? startDateOfTheWeek;

  PaymentByWeek({this.amount, this.startDateOfTheWeek});

  PaymentByWeek.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    startDateOfTheWeek = json['startDateOfTheWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['startDateOfTheWeek'] = this.startDateOfTheWeek;
    return data;
  }
}

class Attendance {
  DateTime? checkOut;

  Attendance({this.checkOut});

  Attendance.fromJson(Map<String, dynamic> json) {
    checkOut = DateTime.tryParse(json['checkOut'])?.toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkOut'] = this.checkOut;
    return data;
  }
}

class UserWorkingTime {
  String? checkIn;
  String? checkOut;
  int? workingTime;

  UserWorkingTime({this.checkIn, this.checkOut, this.workingTime});

  UserWorkingTime.fromJson(Map<String, dynamic> json) {
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    workingTime = json['workingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['workingTime'] = this.workingTime;
    return data;
  }
}
