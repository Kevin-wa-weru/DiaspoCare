import 'package:diasporacare/features/auth/forgot_password/cubit/verify_passwordless_login_otp_cubit.dart';
import 'package:diasporacare/features/decision/desicion.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyPasswordlessOtp extends StatefulWidget {
  const VerifyPasswordlessOtp({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;
  @override
  State<VerifyPasswordlessOtp> createState() => _VerifyPasswordlessOtpState();
}

class _VerifyPasswordlessOtpState extends State<VerifyPasswordlessOtp> {
  String? otpCode;

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

  void showSnackBarWithoutButton(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
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
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10.0, left: 2, right: 2),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<VerifyPasswordlessLoginOtpCubit,
                          VerifyPasswordlessLoginOtpState>(
                        builder: (context, state) {
                          return state.when(initial: () {
                            return Container(
                              height: 4,
                            );
                          }, loading: () {
                            return const LinearProgressIndicator();
                          }, loaded: (message) {
                            return Container(
                              height: 4,
                            );
                          }, error: (message) {
                            return Container(
                              height: 4,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  const Text(
                    'An OTP has been sent to',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'your email',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
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
                        borderSide:
                            BorderSide(width: 2.5, color: Colors.black54),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Colors.black54),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Colors.black54),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height *
                            0.0301231527093596,
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
                                      context
                                          .read<
                                              VerifyPasswordlessLoginOtpCubit>()
                                          .verifyOtp(
                                              otpCode, widget.phoneNumber);
                                    }
                                  },
                                  child: BlocConsumer<
                                      VerifyPasswordlessLoginOtpCubit,
                                      VerifyPasswordlessLoginOtpState>(
                                    listener: (context, state) {
                                      state.when(
                                          initial: () {},
                                          loading: () {},
                                          loaded: (result) {
                                            if (result == 'Otp verified') {
                                              showSnackBarWithoutButton(
                                                  context, result);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const DesicionsPage()));
                                            } else {
                                              showSnackBarWithoutButton(
                                                  context, result);
                                            }
                                          },
                                          error: (failureMessage) {
                                            showSnackBarWithoutButton(
                                                context, failureMessage);
                                          });
                                    },
                                    builder: (context, state) {
                                      return state.when(initial: () {
                                        return Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Verify OTP',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        );
                                      }, loading: () {
                                        return Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            color: loadingButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Verifying...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        );
                                      }, loaded: (message) {
                                        return Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                        );
                                      }, error: (message) {
                                        return Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                        );
                                      });
                                    },
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
                    onTap: () {
                      DiaspoCareAPis.sendPasswordlessLoginOtp(
                          widget.phoneNumber);
                      showSnackBarWithoutButton(
                          context, 'Otp has been regenerated');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Did not receive OTP?',
                          style: TextStyle(
                              color: Colors.black54,
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
