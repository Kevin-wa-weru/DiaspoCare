import 'package:diasporacare/screens/homepage/add_discount.dart';
import 'package:diasporacare/screens/homepage/cubit/get_discounts_cubit.dart';
import 'package:diasporacare/screens/homepage/save_discount.dart';
import 'package:diasporacare/screens/widgets/loading_container_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class Promotions extends StatefulWidget {
  const Promotions({super.key});

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  List<String> promotions = [
    '1',
    '2',
    '3',
    '4',
  ];

  @override
  void initState() {
    context.read<GetDiscountsCubit>().getDiscounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Promotions',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, right: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.055,
          width: MediaQuery.of(context).size.height * 0.18,
          child: FloatingActionButton.extended(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddDiscount()));
            },
            label: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'New Discount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            icon: Transform.translate(
              offset: const Offset(5.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: SvgPicture.asset(
                    'assets/icons/add.svg',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backgroundColor: const Color(0xFF145DA0),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              BlocBuilder<GetDiscountsCubit, GetDiscountsState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text('Discounts ...',
                              style: TextStyle(
                                color: Colors.black12,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    );
                  }, loading: () {
                    return Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text('Discounts ...',
                              style: TextStyle(
                                color: Colors.black12,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    );
                  }, loaded: (m) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text('Discounts (${m.length})',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    );
                  }, error: (m) {
                    return Text(m);
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              BlocBuilder<GetDiscountsCubit, GetDiscountsState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return Column(
                        children: promotions
                            .map(
                              (e) => const SingleLoadingDiscount(),
                            )
                            .toList());
                  }, loading: () {
                    return Column(
                        children: promotions
                            .map(
                              (e) => const SingleLoadingDiscount(),
                            )
                            .toList());
                  }, loaded: (List discounts) {
                    return Column(
                        children: discounts
                            .map(
                              (e) => SingleDiscount(
                                singleDiscount: e,
                              ),
                            )
                            .toList());
                  }, error: (message) {
                    return Text(message);
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class SingleDiscount extends StatelessWidget {
  const SingleDiscount({
    Key? key,
    required this.singleDiscount,
  }) : super(key: key);
  final Map singleDiscount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.61,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              singleDiscount['name1'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                '${singleDiscount['percentage'].toString()}% off',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateDiscount(
                                    discoutId: singleDiscount['name'],
                                  )));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.034,
                      width: MediaQuery.of(context).size.width * 0.19,
                      decoration: BoxDecoration(
                        color: const Color(0xFF145DA0),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black26,
                          width: 0.9,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Divider(
            thickness: 0.8,
            color: Colors.black45,
          ),
        )
      ],
    );
  }
}

class SingleLoadingDiscount extends StatelessWidget {
  const SingleLoadingDiscount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF145DA0),
        highlightColor: Colors.black12,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.61,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                LoadingContainerAnimation(
                                  targetContainer: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.03,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.02,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.034,
                        width: MediaQuery.of(context).size.width * 0.19,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Divider(
                thickness: 0.8,
                color: Colors.black12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
