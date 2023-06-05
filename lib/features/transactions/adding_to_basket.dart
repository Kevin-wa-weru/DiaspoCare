import 'dart:collection';

import 'package:diasporacare/utils/constants.dart';
import 'package:diasporacare/models/paymentlist.dart';
import 'package:diasporacare/features/homepage/home_screen.dart';
import 'package:diasporacare/features/transactions/cubit/add_basket_item_cubit.dart';
import 'package:diasporacare/features/transactions/cubit/get_basket_items_cubit.dart';
import 'package:diasporacare/features/transactions/edit_basket_item.dart';
import 'package:diasporacare/features/transactions/pick_item.dart';
import 'package:diasporacare/features/transactions/request_for_payment.dart';
import 'package:diasporacare/features/widgets/loading_container_animation.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class AddingToBssket extends StatefulWidget {
  const AddingToBssket(
      {super.key,
      required this.basketDetails,
      required this.initialDropdownValue,
      // required this.discounts,
      required this.beneficiaryName,
      required this.discounts});
  final Map<String, dynamic> basketDetails;
  final String initialDropdownValue;
  final List<String> discounts;
  final String beneficiaryName;

  @override
  State<AddingToBssket> createState() => _AddingToBssketState();
}

class _AddingToBssketState extends State<AddingToBssket> {
  final qtyController = TextEditingController();
  final priceController = TextEditingController();

  bool itemHasIssue = false;
  bool qtyHasIssue = false;
  bool discountHasIssue = false;
  bool priceHasIssue = false;

  List<PaymentList> paymentcart = [
    PaymentList(
        name: "Panadol", amount: "4", quantity: "2", discount: "Jamuhuri Day"),
    PaymentList(
        name: "Panadol", amount: "4", quantity: "2", discount: "Jamuhuri Day"),
    PaymentList(
        name: "Panadol", amount: "4", quantity: "2", discount: "Jamuhuri Day"),
    PaymentList(
        name: "Panadol", amount: "4", quantity: "2", discount: "Jamuhuri Day"),
    PaymentList(
        name: "Panadol", amount: "4", quantity: "2", discount: "Jamuhuri DDay"),
  ];

  String dropdownvalue = '';
  String itemPicked = '';

  @override
  void initState() {
    setState(() {
      dropdownvalue = widget.initialDropdownValue;
    });
    context
        .read<GetBasketItemsCubit>()
        .getBasketItems(widget.basketDetails['name']);
    super.initState();
  }

  Future<void> navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PickItem()),
    );
    setState(() {
      if (result == null) {
      } else {
        itemPicked = result;
      }

      if (result != '') {
        itemHasIssue = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Create New Order',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15),
            child: Row(
              children: [
                const Text(
                  "Total Amount : ",
                  style: TextStyle(
                      color: Color(0xFF145DA0),
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                ),
                BlocBuilder<GetBasketItemsCubit, GetBasketItemsState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      );
                    }, loading: () {
                      return LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      );
                    }, loaded: (List items, String currency) {
                      if (items.isEmpty) {
                        return Text("$currency 0.00",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ));
                      } else {
                        List amounts = [];
                        num sum = 0;
                        for (var i in items) {
                          amounts.add(i['price'] * i['quantity']);
                          for (var e in amounts) {
                            sum += e;
                          }
                          amounts = [];
                        }
                        return Text("$currency ${sum.toString()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ));
                      }
                    }, error: (message) {
                      return Text(message,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ));
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomeScreen()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.34,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 1.5, color: const Color(0xFF145DA0))),
                    child: const Center(
                      child: Text("Save Order",
                          style: TextStyle(
                            color: Color(0xFF145DA0),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
                BlocBuilder<GetBasketItemsCubit, GetBasketItemsState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return GestureDetector(
                        onTap: () {
                          showSnackBarWithoutButton(
                              context, 'Add item(s) in the basket');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.51,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: loadingButtonColor),
                          child: const Center(
                            child: Text("Request Payment",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      );
                    }, loading: () {
                      return GestureDetector(
                        onTap: () {
                          showSnackBarWithoutButton(
                              context, 'Add item(s) in the basket');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.51,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: loadingButtonColor),
                          child: const Center(
                            child: Text("Request Payment",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      );
                    }, loaded: (List items, currency) {
                      if (items.isEmpty) {
                        return GestureDetector(
                          onTap: () {
                            showSnackBarWithoutButton(
                                context, 'Add item(s) in the basket');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.51,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: loadingButtonColor),
                            child: const Center(
                              child: Text("Request Payment",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        );
                      } else {
                        List amounts = [];
                        num sum = 0;
                        for (var i in items) {
                          amounts.add(i['price'] * i['quantity']);
                          for (var e in amounts) {
                            sum += e;
                          }
                          amounts = [];
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestPayment(
                                    basketDetails: widget.basketDetails,
                                    beneficiaryName: widget.beneficiaryName,
                                    totalAmount: sum.toString(),
                                    currency: currency,
                                  ),
                                ));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.51,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFF145DA0)),
                            child: const Center(
                              child: Text("Request Payment",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        );
                      }
                    }, error: (message) {
                      return GestureDetector(
                        onTap: () {
                          showSnackBarWithoutButton(
                              context, 'Add item(s) in the basket');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.51,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: loadingButtonColor),
                          child: const Center(
                            child: Text("Request Payment",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      );
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black26)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 12),
                    child: Row(
                      children: [
                        const Text(
                          "Item",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                        itemHasIssue
                            ? const Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "*",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 10,
                      right: 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        navigateAndDisplaySelection(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                width: 1,
                                color: itemHasIssue
                                    ? Colors.red
                                    : Colors.black26)),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  itemPicked,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 16,
                                  ),
                                  child: Text(
                                    "Qty",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                qtyHasIssue
                                    ? Transform.translate(
                                        offset: const Offset(-10.0, 0.0),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            "*",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            Transform.translate(
                              offset: const Offset(-5.0, 0.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16.0, top: 8),
                                  child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: qtyController,
                                      onChanged: (value) {
                                        if (qtyController.text.isNotEmpty) {
                                          setState(() {
                                            qtyHasIssue = false;
                                          });
                                        }
                                      },
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: qtyHasIssue
                                                  ? Colors.red
                                                  : Colors.black26,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: qtyHasIssue
                                                  ? Colors.red
                                                  : Colors.black26,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 16, left: 10),
                                  child: Text(
                                    "Discount",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                discountHasIssue
                                    ? Transform.translate(
                                        offset: const Offset(-10.0, 0.0),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            "*",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  height: MediaQuery.of(context).size.height *
                                      0.052,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          width: 1, color: Colors.black26)),
                                  child: Stack(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: DropdownButton(
                                            isDense: true,
                                            isExpanded: true,
                                            style: widget.discounts[0] ==
                                                    'No discounts available'
                                                ? const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12)
                                                : const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                            value: dropdownvalue,
                                            icon: Container(),
                                            underline: Container(),
                                            items: LinkedHashSet<String>.from(
                                                    widget.discounts)
                                                .toList()
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 16,
                      top: 12,
                    ),
                    child: Row(
                      children: [
                        const Text("Price(Rate)",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                        priceHasIssue
                            ? Transform.translate(
                                offset: const Offset(0.0, 0.0),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "*",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 10,
                      right: 16,
                      bottom: 25,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: priceController,
                          onChanged: (value) {
                            if (priceController.text.isNotEmpty) {
                              setState(() {
                                priceHasIssue = false;
                              });
                            }
                          },
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: priceHasIssue
                                      ? Colors.red
                                      : Colors.black26,
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: priceHasIssue
                                      ? Colors.red
                                      : Colors.black26,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: BlocConsumer<AddBasketItemCubit, AddBasketItemState>(
              listener: (context, state) {
                state.when(
                    initial: () {},
                    loading: () {},
                    loaded: (String message) {
                      context
                          .read<GetBasketItemsCubit>()
                          .getBasketItems(widget.basketDetails['name']);
                      showSnackBarWithoutButton(context, message);
                    },
                    error: (String message) {});
              },
              builder: (context, state) {
                return state.when(initial: () {
                  return InkWell(
                    onTap: () async {
                      if (itemPicked == '') {
                        if (itemPicked.isEmpty) {
                          setState(() {
                            itemHasIssue = true;
                          });
                        } else {
                          setState(() {
                            itemHasIssue = false;
                          });
                        }
                      }

                      if (qtyController.text.isEmpty) {
                        if (qtyController.text.isEmpty) {
                          setState(() {
                            qtyHasIssue = true;
                          });
                        } else {
                          setState(() {
                            qtyHasIssue = false;
                          });
                        }
                      }

                      if (priceController.text.isEmpty) {
                        if (priceController.text.isEmpty) {
                          setState(() {
                            priceHasIssue = true;
                          });
                        } else {
                          setState(() {
                            priceHasIssue = false;
                          });
                        }
                      }

                      if (!itemHasIssue && !qtyHasIssue && !priceHasIssue) {
                        if (dropdownvalue == 'No discounts available') {
                          context.read<AddBasketItemCubit>().addBasketItems(
                                widget.basketDetails['name'],
                                itemPicked,
                                0,
                                int.parse(priceController.text),
                                int.parse(qtyController.text),
                              );
                        } else {
                          context.read<AddBasketItemCubit>().addBasketItems(
                                widget.basketDetails['name'],
                                itemPicked,
                                int.parse(dropdownvalue.split(" ")[0]),
                                int.parse(priceController.text),
                                int.parse(qtyController.text),
                              );
                        }

                        setState(() {
                          itemPicked = '';
                        });

                        priceController.clear();
                        qtyController.clear();
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF145DA0),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Items",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }, loading: () {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF145DA0),
                    ),
                    child: const Center(
                        child:
                            Spinner(heightOfSpinner: 25, widthofSpinnner: 25)),
                  );
                }, loaded: (message) {
                  return InkWell(
                    onTap: () {
                      if (itemPicked == '') {
                        if (itemPicked.isEmpty) {
                          setState(() {
                            itemHasIssue = true;
                          });
                        } else {
                          setState(() {
                            itemHasIssue = false;
                          });
                        }
                      }

                      if (qtyController.text.isEmpty) {
                        if (qtyController.text.isEmpty) {
                          setState(() {
                            qtyHasIssue = true;
                          });
                        } else {
                          setState(() {
                            qtyHasIssue = false;
                          });
                        }
                      }

                      if (priceController.text.isEmpty) {
                        if (priceController.text.isEmpty) {
                          setState(() {
                            priceHasIssue = true;
                          });
                        } else {
                          setState(() {
                            priceHasIssue = false;
                          });
                        }
                      }

                      if (!itemHasIssue && !qtyHasIssue && !priceHasIssue) {
                        context.read<AddBasketItemCubit>().addBasketItems(
                              widget.basketDetails['name'],
                              itemPicked,
                              int.parse(dropdownvalue.split(" ")[0]),
                              int.parse(priceController.text),
                              int.parse(qtyController.text),
                            );

                        setState(() {
                          itemPicked = '';
                        });
                        priceController.clear();
                        qtyController.clear();
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF145DA0),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Items",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }, error: (message) {
                  return InkWell(
                    onTap: () {
                      if (itemPicked == '') {
                        if (itemPicked.isEmpty) {
                          setState(() {
                            itemHasIssue = true;
                          });
                        } else {
                          setState(() {
                            itemHasIssue = false;
                          });
                        }
                      }

                      if (qtyController.text.isEmpty) {
                        if (qtyController.text.isEmpty) {
                          setState(() {
                            qtyHasIssue = true;
                          });
                        } else {
                          setState(() {
                            qtyHasIssue = false;
                          });
                        }
                      }

                      if (priceController.text.isEmpty) {
                        if (priceController.text.isEmpty) {
                          setState(() {
                            priceHasIssue = true;
                          });
                        } else {
                          setState(() {
                            priceHasIssue = false;
                          });
                        }
                      }

                      if (!itemHasIssue && !qtyHasIssue && !priceHasIssue) {
                        context.read<AddBasketItemCubit>().addBasketItems(
                              widget.basketDetails['beneficiary'],
                              itemPicked,
                              int.parse(dropdownvalue.split(" ")[0]),
                              int.parse(priceController.text),
                              int.parse(qtyController.text),
                            );

                        setState(() {
                          itemPicked = '';
                        });
                        priceController.clear();
                        qtyController.clear();
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF145DA0),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Items",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 35, right: 16, bottom: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: BlocBuilder<GetBasketItemsCubit, GetBasketItemsState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentcart.length,
                      itemBuilder: (context, index) {
                        return const SingleLoadingBasketItem();
                      },
                    );
                  }, loading: () {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentcart.length,
                      itemBuilder: (context, index) {
                        return const SingleLoadingBasketItem();
                      },
                    );
                  }, loaded: (List basketItems, currency) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: basketItems.length,
                      itemBuilder: (context, index) {
                        return SingleBasketItem(
                          itemDetails: basketItems[index],
                          basketDetails: widget.basketDetails,
                          beneficiaryName: widget.beneficiaryName,
                          discounts: widget.discounts,
                          initialDropdownValue: widget.initialDropdownValue,
                          currency: currency,
                        );
                      },
                    );
                  }, error: (message) {
                    return Center(
                      child: Text(message),
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleBasketItem extends StatelessWidget {
  const SingleBasketItem({
    Key? key,
    required this.itemDetails,
    required this.basketDetails,
    required this.discounts,
    required this.beneficiaryName,
    required this.initialDropdownValue,
    required this.currency,
  }) : super(key: key);

  final Map<String, dynamic> itemDetails;
  final Map<String, dynamic> basketDetails;

  final List<String> discounts;
  final String beneficiaryName;
  final String initialDropdownValue;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    itemDetails['item'],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 6, 21, 148),
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditBasket(
                                      basketItemDetails: itemDetails,
                                      discounts: discounts,
                                      initialDropdownValue:
                                          initialDropdownValue,
                                    )));
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 0.11,
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          color: const Color(0xFF145DA0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "$currency ${itemDetails['price'] * itemDetails['quantity']}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Qty: ${itemDetails['quantity']} ",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const Text(
                "Discount: No Discount applied",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Divider(
              color: Color.fromARGB(255, 209, 209, 209),
              thickness: 1.5,
            ),
          )
        ],
      ),
    );
  }
}

class SingleLoadingBasketItem extends StatelessWidget {
  const SingleLoadingBasketItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF145DA0),
        highlightColor: Colors.black12,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadingContainerAnimation(
                  targetContainer: Container(
                    height: MediaQuery.of(context).size.width * 0.02,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                LoadingContainerAnimation(
                  targetContainer: Container(
                    height: MediaQuery.of(context).size.width * 0.04,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.02,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.02,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Divider(
                color: Colors.black12,
                thickness: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
