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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['userWorkingTime'] != null) {
      userWorkingTime = <UserWorkingTime>[];
      json['userWorkingTime'].forEach((v) {
        userWorkingTime!.add(UserWorkingTime.fromJson(v));
      });
    }
    totalHoursPerMonth = json['totalHoursPerMonth'];
    thisMonthRevenue = json['thisMonthRevenue'];
    overallRevenue = json['overallRevenue'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (userWorkingTime != null) {
      data['userWorkingTime'] =
          userWorkingTime!.map((v) => v.toJson()).toList();
    }
    data['totalHoursPerMonth'] = totalHoursPerMonth;
    data['thisMonthRevenue'] = thisMonthRevenue;
    data['overallRevenue'] = overallRevenue;
    data['success'] = success;
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
        roles!.add(Roles.fromJson(v));
      });
    }
    if (json['PaymentByWeek'] != null) {
      paymentByWeek = <PaymentByWeek>[];
      json['PaymentByWeek'].forEach((v) {
        paymentByWeek!.add(PaymentByWeek.fromJson(v));
      });
    }
    if (json['Attendance'] != null) {
      attendance = <Attendance>[];
      json['Attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['fullName'] = fullName;
    data['email'] = email;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    if (paymentByWeek != null) {
      data['PaymentByWeek'] =
          paymentByWeek!.map((v) => v.toJson()).toList();
    }
    if (attendance != null) {
      data['Attendance'] = attendance!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleID'] = roleID;
    data['roleName'] = roleName;
    data['rate'] = rate;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['startDateOfTheWeek'] = startDateOfTheWeek;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkOut'] = checkOut;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['workingTime'] = workingTime;
    return data;
  }
}
