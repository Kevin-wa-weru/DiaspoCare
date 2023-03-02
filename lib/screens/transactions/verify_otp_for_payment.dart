import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/transactions/cubit/verify_transaction_otp_cubit.dart';
import 'package:diasporacare/screens/transactions/successfull_payment_request.dart';
import 'package:diasporacare/screens/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyOtpForPayment extends StatefulWidget {
  const VerifyOtpForPayment({super.key, required this.basketDetail});
  final Map<String, dynamic> basketDetail;
  @override
  State<VerifyOtpForPayment> createState() => _VerifyOtpForPaymentState();
}

class _VerifyOtpForPaymentState extends State<VerifyOtpForPayment> {
  String otpCode = '';
  bool otpHasIssue = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Request For Payment',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter OTP to initialize transaction",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text(
            'An OTP was sent to the beneficiary\'s mobile',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          const Text(
            'number. Ask them for this OTP',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          otpHasIssue
              ? const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Invalid OTP. Confirm and retry",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                )
              : Container(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
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
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.5, color: otpHasIssue ? Colors.red : Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.5, color: otpHasIssue ? Colors.red : Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.5, color: otpHasIssue ? Colors.red : Colors.black),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).size.height * 0.0301231527093596,
              ),
              filled: true,
            ),

            showFieldAsBox: true,
            onCodeChanged: (String code) {
              if (code.isEmpty) {
              } else {
                setState(() {
                  otpHasIssue = false;
                });
              }
            },
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
            child: BlocConsumer<VerifyTransactionOtpCubit,
                VerifyTransactionOtpState>(
              listener: (context, state) {
                state.when(
                    initial: () {},
                    loading: () {},
                    loaded: (message) {
                      if (message['status'] == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessfullRequest(
                                basketDetails: widget.basketDetail,
                                secureCode: message['secure_code'],
                              ),
                            ));
                      } else {
                        setState(() {
                          otpHasIssue = true;
                        });
                      }
                    },
                    error: (message) {});
              },
              builder: (context, state) {
                return state.when(initial: () {
                  return InkWell(
                    onTap: () {
                      if (otpCode.isEmpty) {
                        showSnackBarWithoutButton(context, 'Fill the otp');
                      } else {
                        if (otpCode.length != 6) {
                          showSnackBarWithoutButton(
                              context, 'Complete OTP code');
                        } else {
                          context
                              .read<VerifyTransactionOtpCubit>()
                              .verifyOtp(widget.basketDetail['name'], otpCode);
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  );
                }, loading: () {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: const BoxDecoration(
                      color: Color(0xFF145DA0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                        child:
                            Spinner(heightOfSpinner: 20, widthofSpinnner: 20)),
                  );
                }, loaded: (message) {
                  return InkWell(
                    onTap: () {
                      if (otpCode.length != 6) {
                        showSnackBarWithoutButton(context, 'Complete OTP code');
                      } else {
                        context
                            .read<VerifyTransactionOtpCubit>()
                            .verifyOtp(widget.basketDetail['name'], otpCode);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  );
                }, error: (message) {
                  return InkWell(
                    onTap: () {
                      if (otpCode.length != 6) {
                        showSnackBarWithoutButton(context, 'Complete OTP code');
                      } else {
                        context
                            .read<VerifyTransactionOtpCubit>()
                            .verifyOtp(widget.basketDetail['name'], otpCode);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
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
        ],
      ),
    );
  }
}
