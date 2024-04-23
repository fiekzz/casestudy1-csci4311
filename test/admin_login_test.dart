import 'package:flutter/material.dart';
import 'package:casestudy1/login/admin_login.dart'; // Replace with the correct import path for your page.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminLoginScreen(),
    );
  }
}
