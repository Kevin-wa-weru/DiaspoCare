// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state

import 'dart:io';

import 'package:diasporacare/features/auth/sign_in/sign_in.dart';
import 'package:diasporacare/features/homepage/home_screen.dart';
import 'package:diasporacare/features/landing/landing_page.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:diasporacare/services/local_auth.dart';
import 'package:diasporacare/utils/animated_effects.dart';
import 'package:diasporacare/utils/constants.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  bool authenticated = false;
  bool isFirstTimer = false;
  bool isOflline = false;
  bool isRetrying = false;

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  checkifFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? facilityName = prefs.getString('facilityName');
    String? userToken = prefs.getString('userToken');
    bool? isFirstTimeUSer = prefs.getBool('isFirstTimeUser');

    if (isFirstTimeUSer == false) {
      final authenticate = await LocalAuth.authenticate();

      print('Just awaited $authenticated');
      setState(() {
        authenticated = authenticate;
      });
      if (authenticated) {
        var response =
            await DiaspoCareAPis.testTokenValidity(facilityName!, userToken!);

        if (response == false) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        }

        if (response == true) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }

        if (response == 'Server busy try again later') {
          setState(() {
            isOflline = true;
          });
        }
      }

      if (!authenticated) {
        //Retry one more time
        final authenticate = await LocalAuth.authenticate();
        if (!authenticate) {
          exit(0);
        } else {
          setState(() {
            authenticated = true;
          });
        }
      }
    } else {
      setState(() {
        isFirstTimer = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingScreen()));
      });
    }
  }

  resolveLoading() {
    if (authenticated && !isOflline) {
      return const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Center(
          child: Spinner(heightOfSpinner: 30, widthofSpinnner: 30),
        ),
      );
    }

    if (authenticated && isOflline) {
      return Container();
    }

    if (!authenticated && isOflline) {
      return Container();
    }

    if (!authenticated && !isOflline) {
      return Container();
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
            resolveLoading(),
            isOflline
                ? Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: SvgPicture.asset('assets/icons/offline.svg',
                              color: Colors.black45, fit: BoxFit.contain),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ShakeWidget(
                            key: _shakeKey,
                            shakeCount: 3,
                            shakeOffset: 10,
                            shakeDuration: const Duration(milliseconds: 200),
                            child: const Text(
                              'Sorry, something went wrong!',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? facilityName =
                                  prefs.getString('facilityName');
                              String? userToken = prefs.getString('userToken');
                              setState(() {
                                isRetrying = true;
                              });
                              var response =
                                  await DiaspoCareAPis.testTokenValidity(
                                      facilityName!, userToken!);

                              if (response == false) {
                                setState(() {
                                  isOflline = false;
                                  isRetrying = false;
                                });

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              }

                              if (response == true) {
                                setState(() {
                                  isOflline = false;
                                  isRetrying = false;
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }
                              if (response == 'Server busy try again later') {
                                _shakeKey.currentState?.shake();
                                setState(() {
                                  isOflline = true;
                                  isRetrying = false;
                                });
                              }
                            },
                            child: isRetrying
                                ? const Spinner(
                                    heightOfSpinner: 20, widthofSpinnner: 20)
                                : const Text(
                                    'Retry',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
