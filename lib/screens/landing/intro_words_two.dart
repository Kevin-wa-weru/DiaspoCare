import 'package:flutter/material.dart';

class IntroWordsTwo extends StatefulWidget {
  const IntroWordsTwo({super.key});

  @override
  State<IntroWordsTwo> createState() => _IntroWordsTwoState();
}

class _IntroWordsTwoState extends State<IntroWordsTwo> {
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
                  'Manage your patient',
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
                  'refill reminders',
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
