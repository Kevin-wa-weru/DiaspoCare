import 'package:diasporacare/screens/homepage/cubit/check_if_verified_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_best_selling_items_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_vendor_details_cubit.dart';
import 'package:diasporacare/screens/transactions/search_beneficiary.dart';
import 'package:diasporacare/screens/widgets/loading_container_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.vendorName,
    required this.pharmacyName,
  }) : super(key: key);
  final String vendorName;
  final String pharmacyName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFE9EAEC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: SizedBox(
                        height: 50,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    BlocBuilder<CheckIfVerifiedCubit, CheckIfVerifiedState>(
                      builder: (context, state) {
                        return state.when(initial: () {
                          return Padding(
                              padding: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: LoadingContainerAnimation(
                                targetContainer: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.027,
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6.0),
                                      )),
                                ),
                              ));
                        }, loading: () {
                          return Padding(
                              padding: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: LoadingContainerAnimation(
                                targetContainer: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.027,
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6.0),
                                      )),
                                ),
                              ));
                        }, loaded: (bool isVerfified) {
                          if (isVerfified == true) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.027,
                                width: MediaQuery.of(context).size.width * 0.17,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6.0),
                                    )),
                                child: const Center(
                                  child: Text(
                                    'Verified',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.027,
                                width: MediaQuery.of(context).size.width * 0.17,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6.0),
                                    )),
                                child: const Center(
                                  child: Text(
                                    'UnVerified',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          }
                        }, error: (messaeg) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.027,
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6.0),
                                  )),
                              child: const Center(
                                child: Text(
                                  'Verified',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                BlocBuilder<GetVendorDetailsCubit, GetVendorDetailsState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: LoadingContainerAnimation(
                                      targetContainer: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.black12,
                                  ))),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: LoadingContainerAnimation(
                                      targetContainer: Container(
                                    height: 10,
                                    width: 70,
                                    color: Colors.black12,
                                  ))),
                            ],
                          ),
                        ],
                      );
                    }, loading: () {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: LoadingContainerAnimation(
                                      targetContainer: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.black12,
                                  ))),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: LoadingContainerAnimation(
                                      targetContainer: Container(
                                    height: 10,
                                    width: 70,
                                    color: Colors.black12,
                                  ))),
                            ],
                          ),
                        ],
                      );
                    }, loaded: (vendorDetails) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  'Welcome , ${vendorDetails['vendorName']}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: Text(
                                  vendorDetails['facilityName'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }, error: (message) {
                      return Column(
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 25.0),
                                child: Text(
                                  'Welcome , Vendor',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 35.0),
                                child: Text(
                                  'Facility Name...',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              border: Border.all(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Overview',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    'Total Sales',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 10),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(-2, -4),
                                            child: const Text(
                                              'KES',
                                              textScaleFactor: 0.7,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '0.00',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    'Approved Transact..',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: const Offset(0.0, -5.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: SvgPicture.asset(
                                        'assets/icons/arrow.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    'Pending Transactions',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: const Offset(0.0, -5.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: SvgPicture.asset(
                                        'assets/icons/arrow.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    'Transactions Today',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0, top: 10),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: const Offset(0.0, -5.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: SvgPicture.asset(
                                        'assets/icons/arrow.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchBeneficiary(),
                  ));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: const Color(0xFF145DA0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
                border: Border.all(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.white10,
                period: const Duration(seconds: 7),
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: SvgPicture.asset('assets/icons/bill.svg',
                          color: Colors.white, fit: BoxFit.contain),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: SvgPicture.asset('assets/icons/forward_arrow.svg',
                          color: Colors.white, fit: BoxFit.contain),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Start Transaction',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          BlocBuilder<GetBestSellingItemsCubit, GetBestSellingItemsState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: LoadingContainerAnimation(
                                          targetContainer: Container(
                                        color: Colors.black12,
                                        width: 100,
                                        height: 15,
                                      ))),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }, loading: () {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: LoadingContainerAnimation(
                                          targetContainer: Container(
                                        color: Colors.black12,
                                        width: 100,
                                        height: 15,
                                      ))),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }, loaded: (List items) {
                if (items.isEmpty) {
                  return Container();
                } else {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.40,
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
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15.0, top: 10),
                                    child: Text(
                                      'Best Selling Items',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Text(
                                      '1. ${items[0]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Text(
                                      '2. ${items[1]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Text(
                                      '3. ${items[2]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10),
                                    child: Text(
                                      '4. ${items[3]}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }, error: (message) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
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
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: LoadingContainerAnimation(
                                          targetContainer: Container(
                                        color: Colors.black12,
                                        width: 100,
                                        height: 15,
                                      ))),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        color: Colors.black12,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
          ),
        ],
      ),
    ));
  }
}
