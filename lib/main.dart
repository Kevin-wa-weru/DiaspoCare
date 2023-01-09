import 'package:diasporacare/screens/auth/sign_in.dart';
import 'package:diasporacare/screens/auth/sign_up.dart';
import 'package:diasporacare/screens/auth/verify_otp.dart';
import 'package:diasporacare/screens/homepage/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diaspora Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'JosefinSans',
      ),
      home: const SignUp(),
    );
  }
}
