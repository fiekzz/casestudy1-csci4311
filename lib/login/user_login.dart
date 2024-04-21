import 'package:casestudy1/component/payroll_button.dart';
import 'package:casestudy1/component/payroll_textformfield.dart';
import 'package:casestudy1/features/dashboard/user_dashboard.dart';
import 'package:casestudy1/login/admin_login.dart';
import 'package:casestudy1/main.dart';
import 'package:casestudy1/utils/api_manager.dart';
import 'package:casestudy1/utils/ui_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  void login() async {
    try {
      if (loginFormKey.currentState!.validate()) {
        final data = await ApiManager.userLogin(
            emailController.text, passwordController.text);

        const storage = FlutterSecureStorage();

        print(data.data!.token);

        await Future.wait([
          storage.write(
            key: 'token',
            value: data.data!.token ?? '',
          ),
          storage.write(
            key: 'loginType',
            value: 'staff',
          )
        ]);

        // Get user id
        final userID = data.data?.userId;

        if (data.success ?? false) {
          Navigator.pushAndRemoveUntil(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => UserDashboard(userID: userID ?? ''),
            ),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text(data.message ?? 'An error occurred.'),
              backgroundColor: UiColors.alertRed,
            ),
          );
        }
      }
    } catch (error) {
      print(error);
    }

    return;
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 400,
            ),
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PayrollTextformfield(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email Address',
                    validator: (text) {
                      String userInput = text ?? '';

                      return !EmailValidator.validate(userInput)
                          ? 'Invalid email address entered.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  PayrollTextformfield(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                    validator: (text) {
                      String userInput = text ?? '';

                      return userInput.length < 6
                          ? 'Password must be at least 6 characters long.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite,
                    child: PayrollButton(
                      backgroundColor: UiColors.oceanblue,
                      onPressed: () async {
                        // print("bangsat");
                        login();
                      },
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminLoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login as admin',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
