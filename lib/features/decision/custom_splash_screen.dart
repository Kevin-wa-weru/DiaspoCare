import 'package:diasporacare/features/auth/sign_in/sign_in.dart';
import 'package:diasporacare/features/landing/landing_page.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          duration: const Duration(seconds: 2),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Tap again to exit the app',
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13),
              ),
            ],
          ),
          // backgroundColor: const Color(0xFF070606),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 5,
          ),
        ),
        child: Column(
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
      ),
    );
  }
}
