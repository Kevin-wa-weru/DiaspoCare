// ignore_for_file: avoid_unnecessary_containers

import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/transactions/beneficiary_found.dart';
import 'package:diasporacare/screens/transactions/cubit/search_beneficiary_cubit.dart';
import 'package:diasporacare/screens/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBeneficiary extends StatefulWidget {
  const SearchBeneficiary({super.key});

  @override
  State<SearchBeneficiary> createState() => _SearchBeneficiaryState();
}

class _SearchBeneficiaryState extends State<SearchBeneficiary> {
  final searchController = TextEditingController();
  bool searchHasIssue = false;

  void showSnackBarWithoutButton(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
                // fontFamily: 'JosefinSans',
                color: Colors.red,
                fontWeight: FontWeight.w800,
                fontSize: 13),
          ),
        ],
      ),
      // backgroundColor: const Color(0xFF070606),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
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
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Create New Order',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 224, 224, 224))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                            child: Text(
                          "Search Beneficiary",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        )),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 226, 226, 226))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Text(
                                  "Enter Beneficiary ID or Phone Number",
                                  style: TextStyle(
                                      color: searchHasIssue
                                          ? Colors.red
                                          : Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 16, right: 16),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    autofocus: true,
                                    controller: searchController,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          searchHasIssue == false;
                                        });
                                      }
                                    },
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: searchHasIssue
                                                  ? Colors.red
                                                  : Colors.grey,
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: searchHasIssue
                                                  ? Colors.red
                                                  : Colors.grey,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 216, 212, 212)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 1,
                                        ),
                                        hintText: "DC-B-XXXX"),
                                  ),
                                ),
                                BlocConsumer<SearchBeneficiaryCubit,
                                    SearchBeneficiaryState>(
                                  listener: (context, state) {
                                    state.when(
                                        initial: () {},
                                        loading: () {},
                                        loaded: (message) {
                                          if (message['exists'] == true) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BeneficiaryFound(
                                                    beneficiaryDetails: message,
                                                  ),
                                                ));
                                          } else {
                                            showSnackBarWithoutButton(context,
                                                '${searchController.text} not found');
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           BeneficiaryNotFound(
                                            //         searchQuery:
                                            //             searchController.text,
                                            //       ),
                                            //     ));
                                          }
                                        },
                                        error: (message) {});
                                  },
                                  builder: (context, state) {
                                    return state.when(initial: () {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 25),
                                        child: InkWell(
                                          onTap: () {
                                            if (searchController.text.isEmpty) {
                                              setState(() {
                                                searchHasIssue = true;
                                              });
                                            } else {
                                              setState(() {
                                                searchHasIssue = false;
                                              });
                                            }

                                            if (!searchHasIssue) {
                                              context
                                                  .read<
                                                      SearchBeneficiaryCubit>()
                                                  .searchBeneficiary(
                                                      searchController.text
                                                          .trim());
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF145DA0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Search",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }, loading: () {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 25),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF145DA0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: const Center(
                                              child: Spinner(
                                            heightOfSpinner: 20,
                                            widthofSpinnner: 20,
                                          )),
                                        ),
                                      );
                                    }, loaded: (message) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 25),
                                        child: InkWell(
                                          onTap: () {
                                            if (searchController.text.isEmpty) {
                                              setState(() {
                                                searchHasIssue = true;
                                              });
                                            } else {
                                              setState(() {
                                                searchHasIssue = false;
                                              });
                                            }

                                            if (!searchHasIssue) {
                                              context
                                                  .read<
                                                      SearchBeneficiaryCubit>()
                                                  .searchBeneficiary(
                                                      searchController.text
                                                          .trim());
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF145DA0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Search",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }, error: (message) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 25),
                                        child: InkWell(
                                          onTap: () {
                                            if (searchController.text.isEmpty) {
                                              setState(() {
                                                searchHasIssue = true;
                                              });
                                            } else {
                                              setState(() {
                                                searchHasIssue = false;
                                              });
                                            }

                                            if (!searchHasIssue) {}
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF145DA0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Search",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
