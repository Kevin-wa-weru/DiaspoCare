import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/auth/sign_in/sign_in.dart';
import 'package:diasporacare/screens/auth/sign_up/sign_up.dart';
import 'package:diasporacare/screens/landing/intro_words.dart';
import 'package:diasporacare/screens/landing/intro_words_two.dart';
import 'package:flutter/material.dart';

import 'intro_words_three.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  var currentTabs = [
    const IntroWords(),
    const IntroWordsTwo(),
    const IntroWordsThree(),
  ];

  final int _numPages = 3;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    //   if (currentIndex < 3) {
    //     currentIndex++;
    //     pageController.animateToPage(
    //       currentIndex,
    //       duration: const Duration(milliseconds: 350),
    //       curve: Curves.easeIn,
    //     );
    //   } else {
    //     currentIndex = 3;
    //   }
    // });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            // controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: currentTabs,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              color: Colors.transparent,
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0.0, -65.0),
                    child: const Text(
                      'Swipe for more',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildPageIndicator(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.0,
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ));
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),
              const Text(
                'Vendor App',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 17,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
