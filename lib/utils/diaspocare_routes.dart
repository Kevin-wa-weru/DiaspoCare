import 'package:diasporacare/features/auth/forgot_password/forgot_password.dart';
import 'package:diasporacare/features/auth/sign_in/sign_in.dart';
import 'package:diasporacare/features/auth/sign_in/sign_in_two.dart';
import 'package:diasporacare/features/auth/sign_up/sign_up.dart';
import 'package:diasporacare/features/landing/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaspocareRoutes {
  static const String signInOne = '/signInOne';
  static const String signInTwo = '/signInTwo';
  static const String landingScreen = '/landing';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInOne:
        return _route(const SignIn(), signInOne);
      case signInTwo:
        return _route(const SignIntTwo(), signInTwo);
      case landingScreen:
        return _route(const LandingScreen(), landingScreen);
      case signUp:
        return _route(const SignUp(), signUp);
      case forgotPassword:
        return _route(const ForgotPassword(), forgotPassword);

      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: const Text('Diaspocare'),
            ),
            body: const Center(
              child: Text('Unknown page'),
            ),
          ),
          'unknown',
        );
    }
  }

  static Route _route(Widget page, String route) {
    return CupertinoPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
    );
  }
}
