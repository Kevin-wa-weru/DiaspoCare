import 'package:diasporacare/screens/transactions/paymentrequest.dart';
import 'package:flutter/material.dart';

class SelectedMember extends StatefulWidget {
  const SelectedMember({super.key});

  @override
  State<SelectedMember> createState() => _SelectedMemberState();
}

class _SelectedMemberState extends State<SelectedMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Color(0xFF145DA0)),
            child: Center(
                child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 15),
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          // ignore: prefer_const_constructors

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.lightGreen)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Valid Beneficiary",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 54, 165, 58)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Samuel L Jackson"),
                            Text(
                              "DC-KE-0004",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentRequestForm(),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 75, vertical: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 60, 133, 63),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
