import 'dart:async';

import 'package:casestudy1/component/payroll_button.dart';
import 'package:casestudy1/login/user_login.dart';
import 'package:casestudy1/main.dart';
import 'package:casestudy1/utils/api_manager.dart';
import 'package:casestudy1/utils/models/get_user_details_model.dart';
import 'package:casestudy1/utils/models/get_working_status_model.dart';
import 'package:casestudy1/utils/pgettoken.dart';
import 'package:casestudy1/utils/ui_colors.dart';
import 'package:casestudy1/utils/ui_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({
    super.key,
    required this.userID,
  });

  final String userID;

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  Future<dynamic>? fetchAndSetToken;
  Future<dynamic>? fetchAndSetUserDetails;
  Future<dynamic>? fetchAndSetWorkingStatus;

  GetUserDetailsModel? userDetails;
  WorkingStatus? workingStatus = WorkingStatus.FINISHED;

  Future<void> getUserDetails() async {
    final response = await ApiManager.getUserDetails();

    setState(() {
      userDetails = response;
    });
  }

  Future<void> getWorkingStatus() async {
    final response = await ApiManager.getStatus();

    setState(() {
      workingStatus = response;
    });
  }

  Future<void> userLogout() async {
    await const FlutterSecureStorage().deleteAll();
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => const UserLoginScreen(),
      ),
      (route) => false,
    );
  }

  String userToken = '';

  Future<void> getUserToken() async {
    final token = await PGetToken.getRawToken();

    setState(() {
      userToken = token ?? '';
    });
  }

  Future<void> refreshData() async {
    fetchAndSetToken = getUserToken();
    fetchAndSetUserDetails = getUserDetails();
    fetchAndSetWorkingStatus = getWorkingStatus();
  }

  @override
  void initState() {
    fetchAndSetToken = getUserToken();
    fetchAndSetUserDetails = getUserDetails();
    fetchAndSetWorkingStatus = getWorkingStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ImageNetwork(
                                image: UiStyles.userPlaceholder,
                                height: 50,
                                width: 50,
                                fitWeb: BoxFitWeb.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Welcome, ${userDetails?.data?.fullName ?? 'User'}!',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: PayrollButton(
                            borderRadius: 10,
                            backgroundColor: UiColors.alertRed,
                            onPressed: () async {
                              await userLogout();
                            },
                            child: const Center(
                              child: Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  const Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Overall generated: RM${userDetails?.overallRevenue ?? 0} ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Total hours: ${userDetails?.totalHoursPerMonth ?? 0}hr(s)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'This month: RM${userDetails?.thisMonthRevenue ?? 0} ${userDetails?.totalHoursPerMonth ?? 0}hr(s)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Last check out: ${userDetails?.data?.attendance?[0].checkOut != null ? DateFormat('d MMM yyyy  h:mm a').format(userDetails!.data!.attendance?[0].checkOut ?? DateTime.now()) : 'No check out'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: PayrollButton(
                      borderRadius: 10,
                      backgroundColor: UiColors.oceanblue,
                      onPressed: () async {
                        final currentStatus =
                            workingStatus ?? WorkingStatus.FINISHED;

                        if (currentStatus == WorkingStatus.NOTSTARTED) {
                          await ApiManager.userCheckIn();
                        } else if (currentStatus == WorkingStatus.WORKING) {
                          await ApiManager.userCheckOut();
                        }

                        await refreshData();

                        ScaffoldMessenger.of(navigatorKey.currentContext!)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              currentStatus == WorkingStatus.NOTSTARTED
                                  ? 'You have checked in.'
                                  : currentStatus == WorkingStatus.WORKING
                                      ? 'You have checked out.'
                                      : 'You have finished working for the day.',
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          workingStatus == WorkingStatus.NOTSTARTED
                              ? 'Start working'
                              : workingStatus == WorkingStatus.FINISHED
                                  ? 'Done for the day'
                                  : workingStatus == WorkingStatus.WORKING
                                      ? 'Check out'
                                      : 'Start working',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
