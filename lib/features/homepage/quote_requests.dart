import 'package:diasporacare/features/homepage/cubit/get_new_request_count_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_quote_requests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class VendorQoutes extends StatefulWidget {
  const VendorQoutes({super.key});

  @override
  State<VendorQoutes> createState() => _VendorQoutesState();
}

class _VendorQoutesState extends State<VendorQoutes> {
  @override
  void initState() {
    context.read<GetQuoteRequestsCubit>().getQuotes();
    super.initState();
  }

  List fakeList = ['1', '1', '1', '1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Quote Requests',
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text('New Requests',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            BlocBuilder<GetQuoteRequestsCubit, GetQuoteRequestsState>(
              builder: (context, state) {
                return state.when(initial: () {
                  return Column(
                      children: fakeList.map(
                    (e) {
                      return const SingleLoadingQuote();
                    },
                  ).toList());
                }, loading: () {
                  return Column(
                      children: fakeList.map(
                    (e) {
                      return const SingleLoadingQuote();
                    },
                  ).toList());
                }, loaded: (quotes, items, localRequests) {
                  if (quotes.isEmpty) {
                    return const Center(
                      child: Text('No requests are available'),
                    );
                  } else {
                    return Column(
                      children: quotes
                          .map((e) => SingleQuote(
                                quoteDetails: e,
                                itemsDetails: items
                                    .where((element) =>
                                        element['basket']['name'] == e['name'])
                                    .first,
                                localStorage: localRequests,
                              ))
                          .toList(),
                    );
                  }
                }, error: (message) {
                  return Container();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class SingleQuote extends StatelessWidget {
  const SingleQuote({
    Key? key,
    required this.quoteDetails,
    required this.itemsDetails,
    required this.localStorage,
  }) : super(key: key);
  final Map<String, dynamic> quoteDetails;
  final Map<String, dynamic> itemsDetails;
  final List localStorage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/location.svg',
                            color: const Color(0xFF145DA0),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                top: 5,
                              ),
                              child: Text(
                                quoteDetails['province'] ??
                                    'Location unavailable',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                top: 5,
                              ),
                              child: Text(
                                quoteDetails['district'] ?? '',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                    child: Text(
                      '${quoteDetails['distance_to_beneficiary']} km(s) away',
                      style: const TextStyle(
                          color: Color(0xFF145DA0),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      // '26th October 2022, 13:56:34 am',
                      quoteDetails['creation'] == null
                          ? 'Date is unavailable'
                          : '${Jiffy(DateTime.parse(quoteDetails['creation'])).format(' do MMM yyyy')}, ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${DateTime.parse(quoteDetails['creation']).hour}:${DateTime.parse(quoteDetails['creation']).minute}:${DateTime.parse(quoteDetails['creation']).second.round()}"))}',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Beneficiary:',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14, top: 5),
                    child: Text(
                      quoteDetails['beneficiary'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'Items (${quoteDetails['items_count'].toString()})',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Column(
                children: itemsDetails['items']
                    .map<Widget>(
                      (e) => Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.01,
                              width: MediaQuery.of(context).size.width * 0.02,
                              decoration: const BoxDecoration(
                                color: Color(0xFF145DA0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                e['item'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                    child: InkWell(
                      onTap: () async {
                        if (localStorage.contains(quoteDetails['name'])) {
                        } else {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          List<String>? localRequest =
                              prefs.getStringList('localStorageRequest');

                          localRequest!.add(quoteDetails['name']);

                          prefs.setStringList(
                              'localStorageRequest', localRequest);
                          localRequest = [];

                          // ignore: use_build_context_synchronously
                          context
                              .read<GetNewRequestCountCubit>()
                              .manageRequestCount();

                          // ignore: use_build_context_synchronously
                          context.read<GetQuoteRequestsCubit>().getQuotes();
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: localStorage.contains(quoteDetails['name'])
                              ? Colors.transparent
                              : const Color(0xFF145DA0),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: const Color(0xFF145DA0),
                            style: BorderStyle.solid,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            localStorage.contains(quoteDetails['name'])
                                ? 'Request accepted'
                                : 'Accept request',
                            style: TextStyle(
                                color:
                                    localStorage.contains(quoteDetails['name'])
                                        ? Colors.black
                                        : Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleLoadingQuote extends StatelessWidget {
  const SingleLoadingQuote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFF145DA0),
            highlightColor: Colors.black12,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/location.svg',
                              color: Colors.black12,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    top: 5,
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.02,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    top: 5,
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.02,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Beneficiary:',
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 14, top: 5),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        )),
                  ],
                ),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                          width: MediaQuery.of(context).size.width * 0.02,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            )),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
