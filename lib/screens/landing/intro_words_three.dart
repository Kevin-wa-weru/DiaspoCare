import 'package:diasporacare/constants.dart';
import 'package:flutter/material.dart';

class IntroWordsThree extends StatefulWidget {
  const IntroWordsThree({super.key});

  @override
  State<IntroWordsThree> createState() => _IntroWordsThreeState();
}

class _IntroWordsThreeState extends State<IntroWordsThree> {
  bool visible = false;
  @override
  void initState() {
    setState(() {
      visible = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Access to a wide pool',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'of customers',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'real-time',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
