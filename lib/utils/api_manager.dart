import 'package:casestudy1/component/pfetch.dart';
import 'package:casestudy1/utils/models/get_user_details_model.dart';
import 'package:casestudy1/utils/models/get_working_status_model.dart';
import 'package:casestudy1/utils/models/user_login_response_model.dart';

class ApiManager {
  static Future<UserLoginResponseModel> userLogin(
      String email, String password) async {
    try {
      final response = await PFetch(
        '/auth/user-login',
        method: PFetchMethod.POST,
        body: {
          'email': email,
          'password': password,
        },
      ).request();

      return UserLoginResponseModel.fromJson(response);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<GetUserDetailsModel> getUserDetails() async {
    try {
      final response = await PFetch(
        '/users/get-user-details',
        method: PFetchMethod.GET,
      ).authorizedRequest();

      return GetUserDetailsModel.fromJson(response);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> userCheckIn() async {
    try {
      final response = await PFetch(
        'users/user-checkin',
        method: PFetchMethod.POST,
      ).authorizedRequest();

      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> userCheckOut() async {
    try {
      final response = await PFetch(
        'users/user-checkout',
        method: PFetchMethod.POST,
      ).authorizedRequest();

      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<WorkingStatus> getStatus() async {
    try {
      final response = await PFetch(
        '/users/get-working-status',
        method: PFetchMethod.GET,
      ).authorizedRequest();

      final res = GetWorkingStatusModel.fromJson(response);

      return res.data!.status!;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
