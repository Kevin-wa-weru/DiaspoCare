import 'package:diasporacare/utils/constants.dart';
import 'package:diasporacare/features/homepage/cubit/edit_discount_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_discounts_cubit.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UpdateDiscount extends StatefulWidget {
  const UpdateDiscount({super.key, required this.discoutId});
  final String discoutId;
  @override
  State<UpdateDiscount> createState() => _UpdateDiscountState();
}

class _UpdateDiscountState extends State<UpdateDiscount> {
  final discountNameController = TextEditingController();
  final discountAmountController = TextEditingController();
  bool discountNameHasIssue = false;
  bool discountAmountHasIssue = false;

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              bottom: 8,
              top: 8,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(800),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/cancel2.svg',
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Edit Discount',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    const Text(
                      'Discount Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    discountNameHasIssue
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'required',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
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
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 20),
            child: TextFormField(
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: discountNameHasIssue ? Colors.red : secondaryColor,
                      width: 1.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: secondaryColor, width: 1.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                filled: true,
                hintText: '',
                hintStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              onChanged: (value) {
                if (discountNameController.text.isNotEmpty) {
                  setState(() {
                    discountNameHasIssue = false;
                  });
                }
              },
              controller: discountNameController,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    const Text(
                      'Discount (%) e.g 10',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    discountAmountHasIssue
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'required',
                              style: TextStyle(
                                fontSize: 12,
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
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 20),
            child: TextFormField(
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          discountAmountHasIssue ? Colors.red : secondaryColor,
                      width: 1.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: secondaryColor, width: 1.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                filled: true,
                hintText: '',
                hintStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              onChanged: (value) {
                if (discountAmountController.text.isNotEmpty) {
                  setState(() {
                    discountAmountHasIssue = false;
                  });
                }
              },
              controller: discountAmountController,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          BlocConsumer<EditDiscountCubit, EditDiscountState>(
            listener: (context, state) {
              state.when(
                  initial: () {},
                  loading: () {},
                  loaded: (result) {
                    if (result == 'Discount edited successfully') {
                      showSnackBarWithoutButton(context, result);
                      Navigator.pop(context);
                      context.read<GetDiscountsCubit>().getDiscounts();
                    } else {
                      showSnackBarWithoutButton(context, result);
                    }
                  },
                  error: (failureMessage) {
                    showSnackBarWithoutButton(context, failureMessage);
                  });
            },
            builder: (context, state) {
              return state.when(initial: () {
                return Transform.translate(
                  offset: const Offset(-5.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      if (discountAmountController.text.isEmpty) {
                        setState(() {
                          discountAmountHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountAmountHasIssue = false;
                        });
                      }

                      if (discountNameController.text.isEmpty) {
                        setState(() {
                          discountNameHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountNameHasIssue = false;
                        });
                      }

                      if (!discountAmountHasIssue && !discountAmountHasIssue) {
                        context.read<EditDiscountCubit>().editDiscount(
                            discountNameController.text,
                            int.parse(discountAmountController.text),
                            widget.discoutId);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF145DA0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                );
              }, loading: () {
                return Transform.translate(
                  offset: const Offset(-5.0, 0.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF145DA0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                        child: Spinner(
                      heightOfSpinner: 25,
                      widthofSpinnner: 25,
                    )),
                  ),
                );
              }, loaded: (message) {
                return Transform.translate(
                  offset: const Offset(-5.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      if (discountAmountController.text.isEmpty) {
                        setState(() {
                          discountAmountHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountAmountHasIssue = false;
                        });
                      }

                      if (discountNameController.text.isEmpty) {
                        setState(() {
                          discountNameHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountNameHasIssue = false;
                        });
                      }

                      if (!discountAmountHasIssue && !discountAmountHasIssue) {
                        context.read<EditDiscountCubit>().editDiscount(
                            discountNameController.text,
                            int.parse(discountAmountController.text),
                            widget.discoutId);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF145DA0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                );
              }, error: (message) {
                return Transform.translate(
                  offset: const Offset(-5.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      if (discountAmountController.text.isEmpty) {
                        setState(() {
                          discountAmountHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountAmountHasIssue = false;
                        });
                      }

                      if (discountNameController.text.isEmpty) {
                        setState(() {
                          discountNameHasIssue = true;
                        });
                      } else {
                        setState(() {
                          discountNameHasIssue = false;
                        });
                      }

                      if (!discountAmountHasIssue && !discountAmountHasIssue) {
                        context.read<EditDiscountCubit>().editDiscount(
                            discountNameController.text,
                            int.parse(discountAmountController.text),
                            widget.discoutId);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF145DA0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
