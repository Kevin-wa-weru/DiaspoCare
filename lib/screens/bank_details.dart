import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:diasporacare/services/misc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final accountNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool bankNamehasIssue = false;
  bool accountNamehasIssue = false;
  bool accountNumberdHasIssue = false;
  bool showPassword = true;

  bool phoneIsValid = true;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
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
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Please add your bank details ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'So we know where to pay you!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          'Bank Name',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'AvenirNext',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        bankNamehasIssue
                            ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'required',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'AvenirNext',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: bankNamehasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                              ),
                              onChanged: (value) {
                                if (bankNameController.text.isNotEmpty) {
                                  setState(() {
                                    bankNamehasIssue = false;
                                  });
                                }
                              },
                              controller: bankNameController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Account Name',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    accountNamehasIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: accountNamehasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                              ),
                              onChanged: (value) {
                                if (accountNameController.text.isNotEmpty) {
                                  setState(() {
                                    accountNamehasIssue = false;
                                  });
                                }
                              },
                              controller: accountNameController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Account Number',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    accountNumberdHasIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'AvenirNext',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: accountNumberdHasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'AvenirNext',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onChanged: (value) {
                                if (accountNumberController.text.isNotEmpty) {
                                  setState(() {
                                    accountNumberdHasIssue = false;
                                  });
                                }
                              },
                              controller: accountNumberController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            InkWell(
                              onTap: () {
                                if (accountNameController.text.isEmpty) {
                                  setState(() {
                                    accountNamehasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    accountNamehasIssue = false;
                                  });
                                }

                                if (bankNameController.text.isEmpty) {
                                  setState(() {
                                    bankNamehasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    bankNamehasIssue = false;
                                  });
                                }

                                if (accountNumberController.text.isEmpty) {
                                  setState(() {
                                    accountNumberdHasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    accountNumberdHasIssue = false;
                                  });
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
                                    'Save Bank Details',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    )
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
