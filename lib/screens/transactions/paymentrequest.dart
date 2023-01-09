import 'dart:ui';

import 'package:diasporacare/models/paymentlist.dart';
import 'package:flutter/material.dart';

class PaymentRequestForm extends StatefulWidget {
  const PaymentRequestForm({super.key});

  @override
  State<PaymentRequestForm> createState() => _PaymentRequestFormState();
}

class _PaymentRequestFormState extends State<PaymentRequestForm> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF145DA0),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
                child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 0, top: 0),
                  child: Text(
                    "Create New Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: const [
                Text(
                  "Total Amount: ",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF145DA0),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "KES 15,980",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1.5, color: const Color(0xFF145DA0))),
                  child: const Center(
                    child: Text(
                      "Save Order",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF145DA0)),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF145DA0)),
                  child: const Center(
                    child: Text(
                      "Request Payment",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 16, bottom: 25),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 194, 194))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 16),
                    child: Row(
                      children: const [
                        Text(
                          "Item",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 16, right: 16, bottom: 16),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black54, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 16,
                              ),
                              child: Text(
                                "Qty",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 8),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 16,
                              ),
                              child: Text("Discount",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 8),
                                child: TextFormField(
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
                                          borderSide: const BorderSide(
                                              color: Colors.black54,
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black54,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 40,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 16,
                    ),
                    child: Row(
                      children: const [
                        Text("Price(Rate)",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 16, right: 16, bottom: 16),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 35, right: 16, bottom: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: paymentcart.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentcart[index].name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 6, 21, 148),
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "KES ${paymentcart[index].amount}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Qty: ${paymentcart[index].quantity} "),
                            Text("Discount: ${paymentcart[index].discount}")
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
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Total Amount: KES 15,980",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1.5, color: const Color(0xFF145DA0))),
                  child: const Center(
                    child: Text(
                      "Save Order",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF145DA0)),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF145DA0)),
                  child: const Center(
                    child: Text(
                      "Request Payment",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
