import 'package:diasporacare/features/transactions/cubit/edit_basket_item_cubit.dart';
import 'package:diasporacare/features/transactions/cubit/get_basket_items_cubit.dart';
import 'package:diasporacare/features/transactions/pick_item.dart';
import 'package:diasporacare/features/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditBasket extends StatefulWidget {
  const EditBasket({
    super.key,
    required this.basketItemDetails,
    required this.initialDropdownValue,
    required this.discounts,
  });
  // final Map<String, dynamic> basketDetails;
  final Map<String, dynamic> basketItemDetails;

  final String initialDropdownValue;
  final List<String> discounts;
  // final String beneficiaryName;

  @override
  State<EditBasket> createState() => _EditBasketState();
}

class _EditBasketState extends State<EditBasket> {
  final qtyController = TextEditingController();
  final priceController = TextEditingController();

  bool itemHasIssue = false;
  bool qtyHasIssue = false;
  bool discountHasIssue = false;
  bool priceHasIssue = false;
  String dropdownvalue = '';
  String itemPicked = '';

  @override
  void initState() {
    setState(() {
      dropdownvalue = widget.initialDropdownValue;
      itemPicked = widget.basketItemDetails['item'];
      priceController.text = widget.basketItemDetails['price']
          .round()
          .toString()
          .replaceAll("-", "");
      qtyController.text = widget.basketItemDetails['quantity'].toString();
    });
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
          'Edit Basket Item',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
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
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
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
                                            items: widget.discounts
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
            child: BlocConsumer<EditBasketItemCubit, EditBasketItemState>(
              listener: (context, state) {
                state.when(
                    initial: () {},
                    loading: () {},
                    loaded: (String message) {
                      context
                          .read<GetBasketItemsCubit>()
                          .getBasketItems(widget.basketItemDetails['basket']);

                      showSnackBarWithoutButton(context, message);
                      Navigator.pop(context);
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
                        context.read<EditBasketItemCubit>().editBasketItem(
                              widget.basketItemDetails['name'],
                              itemPicked,
                              // int.parse(dropdownvalue.split(" ")[0]),
                              int.parse(priceController.text),
                              int.parse(qtyController.text),
                            );
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
                          "Save Changes",
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
                        context.read<EditBasketItemCubit>().editBasketItem(
                              widget.basketItemDetails['name'],
                              itemPicked,
                              // int.parse(dropdownvalue.split(" ")[0]),
                              int.parse(priceController.text),
                              int.parse(qtyController.text),
                            );
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
                          "Save Changes",
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
                        context.read<EditBasketItemCubit>().editBasketItem(
                            widget.basketItemDetails['name'],
                            itemPicked,
                            // int.parse(dropdownvalue.split(" ")[0]),
                            int.parse(priceController.text),
                            int.parse(qtyController.text));
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
                          "Save Changes",
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
        ],
      ),
    );
  }
}
