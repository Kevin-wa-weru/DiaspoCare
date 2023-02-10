import 'package:diasporacare/screens/homepage/cubit/get_discounts_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/add_basket_cubit.dart';
import 'package:diasporacare/screens/transactions/adding_to_basket.dart';
import 'package:diasporacare/screens/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryFound extends StatefulWidget {
  const BeneficiaryFound({super.key, required this.beneficiaryDetails});
  final Map<String, dynamic> beneficiaryDetails;
  @override
  State<BeneficiaryFound> createState() => _BeneficiaryFoundState();
}

class _BeneficiaryFoundState extends State<BeneficiaryFound> {
  List<String> discounts = [];

  @override
  void initState() {
    prepareDiscounts();
    super.initState();
  }

  prepareDiscounts() async {
    List response = await context.read<GetDiscountsCubit>().getDiscounts();
    // discounts.add('Select a discount');
    for (var i in response) {
      discounts.add('${i['percentage']} % off - ${i['name1'].split(" ")[0]} ');
    }
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: const Color(0x8049be25))),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Text(
                        "Valid Beneficiary",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1.5, color: const Color(0x9949be25)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${widget.beneficiaryDetails['user'][0]['full_name']}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '${widget.beneficiaryDetails['beneficiary']['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          ]),
                    ),
                    BlocConsumer<AddBasketCubit, AddBasketState>(
                      listener: (context, state) {
                        state.when(
                            initial: () {},
                            loading: () {},
                            loaded: (message) async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddingToBssket(
                                      basketDetails: message,
                                      discounts: discounts,
                                      initialDropdownValue: discounts[0],
                                      beneficiaryName:
                                          widget.beneficiaryDetails['user'][0]
                                              ['full_name'],
                                    ),
                                  ));
                            },
                            error: (message) {});
                      },
                      builder: (context, state) {
                        return state.when(initial: () {
                          return InkWell(
                            onTap: () {
                              context.read<AddBasketCubit>().addBasket(widget
                                  .beneficiaryDetails['beneficiary']['name']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 65, vertical: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 60, 133, 63),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, loading: () {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 65, vertical: 16),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 60, 133, 63),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                  child: Spinner(
                                      heightOfSpinner: 15,
                                      widthofSpinnner: 15)),
                            ),
                          );
                        }, loaded: (message) {
                          return InkWell(
                            onTap: () {
                              context.read<AddBasketCubit>().addBasket(widget
                                  .beneficiaryDetails['beneficiary']['name']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 65, vertical: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 60, 133, 63),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, error: (message) {
                          return InkWell(
                            onTap: () {
                              context.read<AddBasketCubit>().addBasket(widget
                                  .beneficiaryDetails['beneficiary']['name']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 65, vertical: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 60, 133, 63),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
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
    );
  }
}
