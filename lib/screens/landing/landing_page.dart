import 'dart:async';
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
  PageController pageController = PageController();
  int currentIndex = 0;
  var currentTabs = [
    const IntroWords(),
    const IntroWordsTwo(),
    const IntroWordsThree(),
    const SignUp()
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 3) {
        currentIndex++;
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = 3;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: currentTabs,
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
