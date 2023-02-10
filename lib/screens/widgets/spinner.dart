import 'dart:math';
import 'package:diasporacare/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Spinner extends StatefulWidget {
  const Spinner(
      {super.key,
      required this.heightOfSpinner,
      required this.widthofSpinnner});
  final double heightOfSpinner;
  final double widthofSpinnner;
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  AnimationController? firstController;
  Animation<double>? firstAnimation;

  AnimationController? secondController;
  Animation<double>? secondAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    firstAnimation =
        Tween<double>(begin: -pi, end: pi).animate(firstController!)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstController!.repeat();
            } else if (status == AnimationStatus.dismissed) {
              firstController!.forward();
            }
          });

    secondController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    secondAnimation = Tween<double>(begin: -1, end: -4).animate(
        CurvedAnimation(parent: secondController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController!.forward();
        }
      });

    firstController!.forward();
    secondController!.forward();
  }

  @override
  void dispose() {
    firstController!.dispose();
    secondController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightOfSpinner,
      width: widget.widthofSpinnner,
      child: CustomPaint(
        painter: MyCustomPainter(
          firstAnimation!.value,
          secondAnimation!.value,
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;

  MyCustomPainter(this.startAngle, this.sweepAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint myCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      size.width * .5,
      myCircle,
    );

    Paint myArc = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTRB(0, 0, size.width, size.height),
      startAngle,
      sweepAngle,
      false,
      myArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SpinnerTwo extends StatefulWidget {
  const SpinnerTwo(
      {super.key,
      required this.heightOfSpinner,
      required this.widthofSpinnner});
  final double heightOfSpinner;
  final double widthofSpinnner;
  @override
  _SpinnerTwoState createState() => _SpinnerTwoState();
}

class _SpinnerTwoState extends State<SpinnerTwo> with TickerProviderStateMixin {
  AnimationController? firstController;
  Animation<double>? firstAnimation;

  AnimationController? secondController;
  Animation<double>? secondAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    firstAnimation =
        Tween<double>(begin: -pi, end: pi).animate(firstController!)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstController!.repeat();
            } else if (status == AnimationStatus.dismissed) {
              firstController!.forward();
            }
          });

    secondController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    secondAnimation = Tween<double>(begin: -1, end: -4).animate(
        CurvedAnimation(parent: secondController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController!.forward();
        }
      });

    firstController!.forward();
    secondController!.forward();
  }

  @override
  void dispose() {
    firstController!.dispose();
    secondController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightOfSpinner,
      width: widget.widthofSpinnner,
      child: CustomPaint(
        painter: MyCustomPainter(
          firstAnimation!.value,
          secondAnimation!.value,
        ),
      ),
    );
  }
}

class MyCustomPainterTwo extends CustomPainter {
  final double startAngle;
  final double sweepAngle;

  MyCustomPainterTwo(this.startAngle, this.sweepAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint myCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      size.width * .5,
      myCircle,
    );

    Paint myArc = Paint()
      ..color = const Color(0xFF145DA0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTRB(0, 0, size.width, size.height),
      startAngle,
      sweepAngle,
      false,
      myArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
