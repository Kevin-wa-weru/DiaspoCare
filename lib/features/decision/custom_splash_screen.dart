import 'package:diasporacare/features/auth/sign_in/sign_in.dart';
import 'package:diasporacare/features/landing/landing_page.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  checkifFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTimeUSer = prefs.getBool('isFirstTimeUser');

    if (isFirstTimeUSer == false) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingScreen()));
      });
    }
  }

  @override
  void initState() {
    checkifFirstTimeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          const Text(
            'Vendor App',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 17,
                fontWeight: FontWeight.w800),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: Spinner(heightOfSpinner: 30, widthofSpinnner: 30),
            ),
          ),
        ],
      ),
    );
  }
}
