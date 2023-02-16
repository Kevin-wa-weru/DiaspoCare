import 'package:diasporacare/screens/auth/bank_details/cubit/bank_details_cubit.dart';
import 'package:diasporacare/screens/auth/bank_details/pick_bank_name.dart';
import 'package:diasporacare/screens/auth/complete_profile/assign_tag.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final accountNameController = TextEditingController();
  String bankName = '';
  final accountNumberController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool bankNamehasIssue = false;
  bool accountNamehasIssue = false;
  bool accountNumberdHasIssue = false;
  bool showPassword = true;

  bool phoneIsValid = true;
  bool checkBoxValue = false;

  late List<dynamic> banknames = [];

  Future<void> navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PickBankName()),
    );
    setState(() {
      if (result == null) {
      } else {
        bankName = result;
      }

      if (result != '') {
        bankNamehasIssue = false;
      }
    });
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
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(bottom: 10.0, left: 2, right: 2),
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: BlocBuilder<BankDetailsCubit, BankDetailsState>(
                  //       builder: (context, state) {
                  //         return state.when(initial: () {
                  //           return Container();
                  //         }, loading: () {
                  //           return const LinearProgressIndicator();
                  //         }, loaded: (message) {
                  //           return Container();
                  //         }, error: (message) {
                  //           return Container();
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.03,
                  // ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/logo.png'),
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
                          'Please add your bank details ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'So we know where to pay you!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
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
                                  color: Colors.black54,
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
                                InkWell(
                                  onTap: () {
                                    navigateAndDisplaySelection(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: bankNamehasIssue
                                            ? Colors.red
                                            : secondaryColor,
                                        width: 1.6,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            bankName,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Account Name',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        accountNamehasIssue
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Account Number',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        accountNumberdHasIssue
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  onChanged: (value) {
                                    if (accountNumberController
                                        .text.isNotEmpty) {
                                      setState(() {
                                        accountNumberdHasIssue = false;
                                      });
                                    }
                                  },
                                  controller: accountNumberController,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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

                                    if (bankName.isEmpty) {
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

                                    if (!accountNamehasIssue &&
                                        !bankNamehasIssue &&
                                        !accountNumberdHasIssue) {
                                      context
                                          .read<BankDetailsCubit>()
                                          .saveBankDetails(
                                              bankName,
                                              accountNameController.text,
                                              accountNumberController.text);
                                    }
                                  },
                                  child: BlocConsumer<BankDetailsCubit,
                                      BankDetailsState>(
                                    listener: (context, state) {
                                      state.when(
                                          initial: () {},
                                          loading: () {},
                                          loaded: (result) {
                                            if (result ==
                                                'Bank details succesfully updated') {
                                              showSnackBarWithoutButton(
                                                  context, result);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AreaOfSpecialty()));
                                            } else {
                                              showSnackBarWithoutButton(
                                                  context, result);
                                            }
                                          },
                                          error: (message) {});
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
                                              'Save Bank Details',
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
                                              'Saving Bank Details...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        );
                                      }, loaded: (mesage) {
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
                                              'Save Bank Details',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
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
                                              'Save Bank Details',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                BlocBuilder<BankDetailsCubit, BankDetailsState>(
                                  builder: (context, state) {
                                    return state.when(initial: () {
                                      return Container();
                                    }, loading: () {
                                      return const LinearProgressIndicator();
                                    }, loaded: (message) {
                                      return Container();
                                    }, error: (message) {
                                      return Container();
                                    });
                                  },
                                )
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
