import 'package:flutter/material.dart';

class IntroWords extends StatefulWidget {
  const IntroWords({super.key});

  @override
  State<IntroWords> createState() => _IntroWordsState();
}

class _IntroWordsState extends State<IntroWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Receive Payments from',
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'anywhere in the globe in',
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'real-time',
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 22,
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
