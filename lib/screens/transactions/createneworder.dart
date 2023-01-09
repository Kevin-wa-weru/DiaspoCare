// ignore_for_file: avoid_unnecessary_containers

import 'package:diasporacare/screens/transactions/beneficiarysearched.dart';
import 'package:flutter/material.dart';

class Mybeneficiarysearch extends StatefulWidget {
  const Mybeneficiarysearch({super.key});

  @override
  State<Mybeneficiarysearch> createState() => _MybeneficiarysearchState();
}

class _MybeneficiarysearchState extends State<Mybeneficiarysearch> {
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
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
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
                                const Text(
                                  "Enter Beneficiary ID or Phone Number",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 16, right: 16),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
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
                                                color: Colors.grey, width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 216, 212, 212)),
                                          hintText: "DC-B-XXXX"),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SelectedMember(),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 25),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
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
                )),
          ),
        ],
      ),
    );
  }
}
