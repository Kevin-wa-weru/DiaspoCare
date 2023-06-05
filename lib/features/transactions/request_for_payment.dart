import 'package:diasporacare/features/transactions/cubit/generate_transaction_otp_cubit.dart';
import 'package:diasporacare/features/transactions/verify_otp_for_payment.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class RequestPayment extends StatefulWidget {
  const RequestPayment(
      {super.key,
      required this.basketDetails,
      required this.totalAmount,
      required this.beneficiaryName,
      required this.currency});
  final Map<String, dynamic> basketDetails;
  final String totalAmount;
  final String beneficiaryName;
  final String currency;
  @override
  State<RequestPayment> createState() => _RequestPaymentState();
}

class _RequestPaymentState extends State<RequestPayment> {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Request payment for Order# ${widget.basketDetails['name']}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width * 0.62,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black26)),
              child: Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Center(
                        child: Text(
                          'Beneficiary',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.beneficiaryName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Center(
                        child: Text(
                          'Date',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      // '5 Feb 23 19:43',
                      '${Jiffy(DateTime.now()).format(' do MMM yyyy')}, ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second.round()}"))}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Center(
                        child: Text(
                          'Amount',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${widget.currency} ${widget.totalAmount}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          BlocConsumer<GenerateTransactionOtpCubit,
              GenerateTransactionOtpState>(
            listener: (context, state) {
              state.when(
                  initial: () {},
                  loading: () {},
                  loaded: (message) {
                    if (message == 'Error sending otp') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtpForPayment(
                              basketDetail: widget.basketDetails,
                            ),
                          ));
                      // showSnackBarWithoutButton(
                      //     context, 'There was an error sending Otp');
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtpForPayment(
                              basketDetail: widget.basketDetails,
                            ),
                          ));
                    }
                  },
                  error: (message) {});
            },
            builder: (context, state) {
              return state.when(initial: () {
                return InkWell(
                  onTap: () {
                    context
                        .read<GenerateTransactionOtpCubit>()
                        .generateOtp(widget.basketDetails['name']);
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
                        "Request Payment",
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
                      child: Spinner(heightOfSpinner: 20, widthofSpinnner: 20)),
                );
              }, loaded: (message) {
                return InkWell(
                  onTap: () {
                    context
                        .read<GenerateTransactionOtpCubit>()
                        .generateOtp(widget.basketDetails['name']);
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
                        "Request Payment",
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
                    context
                        .read<GenerateTransactionOtpCubit>()
                        .generateOtp(widget.basketDetails['name']);
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
                        "Request Payment",
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
          )
        ],
      ),
    );
  }
}
