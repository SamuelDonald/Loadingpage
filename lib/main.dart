import 'package:flutter/material.dart';
import 'package:flutterlogin/loginpage.dart';
import 'package:flutterlogin/newloginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: NewLoginPage(),
    );
  }
}
