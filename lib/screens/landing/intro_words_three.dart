import 'package:diasporacare/screens/widgets/spinner.dart';
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
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Access to a wide pool',
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
                  'of customers',
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  'real-time',
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: AnimatedOpacity(
                    opacity: visible ? 1.0 : 0.0,
                    duration: const Duration(seconds: 2),
                    child: const SpinnerTwo(
                        heightOfSpinner: 20, widthofSpinnner: 20)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
