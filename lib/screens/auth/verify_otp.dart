import 'package:diasporacare/screens/auth/profile_completed.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  String? otpCode;
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      duration: const Duration(seconds: 10),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 15.0),
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Container(
              height: 35,
              width: 80,
              color: const Color(0xFF181717),
              child: const Center(
                child: Text(
                  'Okay',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 13),
                ),
              ),
            ),
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
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SvgPicture.asset('assets/images/logo.svg',
                          fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Almost there!\nLet\'s verify your phone',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              const Text(
                'An OTP has been sent to',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                '+254704122812',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: const Color(0xFFEFEFEF),
                borderColor: Colors.transparent,

                hasCustomInputDecoration: true,
                fieldWidth: MediaQuery.of(context).size.width * 0.12,
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
                  fillColor: Colors.transparent,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.5, color: Colors.black),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.5, color: Colors.black),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.5, color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical:
                        MediaQuery.of(context).size.height * 0.0301231527093596,
                  ),
                  filled: true,
                ),

                showFieldAsBox: true,

                onCodeChanged: (String code) {},

                onSubmit: (String verificationCode) {
                  setState(() {
                    otpCode = verificationCode;
                  });
                }, // end onSubmit
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        color: Colors.transparent,
                        //.red
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (otpCode == null) {
                                  showSnackBar(context, 'Complete the OTP');
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileComplete()));
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Did not receive OTP?',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Resend',
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
