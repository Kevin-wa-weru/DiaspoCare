// ignore_for_file: use_build_context_synchronously

import 'package:diasporacare/features/homepage/cubit/change_threshold_widget_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_pay_transfers_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_payout_threshold_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/update_payout_threshold_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jiffy/jiffy.dart';

class PayOuts extends StatefulWidget {
  const PayOuts({
    super.key,
    required this.amount,
    required this.currency,
  });
  final String amount;
  final String currency;
  @override
  State<PayOuts> createState() => _PayOutsState();
}

class _PayOutsState extends State<PayOuts> {
  int activationStep = 0;

  @override
  void initState() {
    context
        .read<ChangeThresholdWidgetCubit>()
        .resolveInitialWidget(widget.amount);
    context.read<GetPayTransfersCubit>().getTransfers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              bottom: 8,
              top: 8,
            ),
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                bool? isVisible = prefs.getBool('payoutVisible');

                context
                    .read<GetPayoutThresholdCubit>()
                    .getPayoutThreshold(isVisible!);
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
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Payouts',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9EAEC),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: BlocBuilder<ChangeThresholdWidgetCubit,
                    ChangeThresholdWidgetState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return Container();
                    }, loading: () {
                      return Container();
                    }, loaded: (amount, index) {
                      if (index == 1) {
                        return const StepOne();
                      }

                      if (index == 2) {
                        return StepTwo(
                          currency: widget.currency,
                        );
                      }

                      if (index == 3) {
                        return StepThree(
                          amount: amount,
                          currency: widget.currency,
                        );
                      } else {
                        return Container();
                      }
                    }, error: (m) {
                      return Container();
                    });
                  },
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Color(0xFFE9EAEC),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Text('Payout History',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          BlocBuilder<GetPayTransfersCubit, GetPayTransfersState>(
            builder: (context, state) {
              return state.when(initial: () {
                return PayoutsLoading();
              }, loading: () {
                return PayoutsLoading();
              }, loaded: (m) {
                if (m.isEmpty) {
                  return const Text('No payouts available',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ));
                } else {
                  // return PayoutsLoading();
                  return Payouts(
                    payouts: m,
                    currency: widget.currency,
                  );
                }
              }, error: (m) {
                return Container();
              });
            },
          ),
        ],
      )),
    );
  }
}

class Payouts extends StatelessWidget {
  const Payouts({
    Key? key,
    required this.payouts,
    required this.currency,
  }) : super(key: key);
  final List payouts;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
              children: payouts
                  .map<Widget>(
                    (e) => Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date:${Jiffy(DateTime.parse(e['creation'])).format(' do MMM yyyy')}',
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Transaction ID: ${e['transaction']}',
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Transfer Amount:',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$currency ${e['transfer_amount']}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  e['status'] != 'completed'
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 2.0),
                                              child: Text(
                                                'Contact Support',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Text(
                                    e['status'] == 'completed'
                                        ? 'Completed'
                                        : 'Failed',
                                    style: TextStyle(
                                        color: e['status'] == 'completed'
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PayoutsLoading extends StatelessWidget {
  PayoutsLoading({
    Key? key,
  }) : super(key: key);
  List transfers = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0xFF145DA0),
            highlightColor: Colors.black12,
            child: Column(
                children: transfers
                    .map<Widget>(
                      (e) => Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 1,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class StepThree extends StatelessWidget {
  const StepThree({
    Key? key,
    required this.amount,
    required this.currency,
  }) : super(key: key);
  final String amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              right: 8.0,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: InkWell(
              onTap: () {
                context.read<ChangeThresholdWidgetCubit>().toogleWidget('', 3);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: const Color(0xFF145DA0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text('Payout Threshold',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Text(
                'Threshold Amount',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                '$currency $amount',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StepTwo extends StatefulWidget {
  const StepTwo({
    Key? key,
    required this.currency,
  }) : super(key: key);
  final String currency;
  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  bool fieldhasIssue = false;
  var fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text('Payout Threshold',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          const Text(
            'Threshold Amount',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextFormField(
                autofocus: true,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: Colors.black12, width: 0),
                  ),
                  prefixText: widget.currency,
                  hintText: 'Threshold amount',
                  hintStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                  prefixStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: fieldhasIssue ? Colors.red : Colors.black54,
                        width: 1.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  filled: true,
                ),
                onChanged: (value) {
                  if (fieldController.text.isNotEmpty) {
                    setState(() {
                      fieldhasIssue = false;
                    });
                  }
                },
                controller: fieldController,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: BlocConsumer<UpdatePayoutThresholdCubit,
                UpdatePayoutThresholdState>(
              listener: (context, state) {
                state.when(
                    initial: () {},
                    loading: () {},
                    loaded: (m) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      bool? isVisible = prefs.getBool('payoutVisible');
                      context
                          .read<ChangeThresholdWidgetCubit>()
                          .toogleWidget(m, 2);
                      context
                          .read<GetPayoutThresholdCubit>()
                          .getPayoutThreshold(isVisible!);
                    },
                    error: (m) {});
              },
              builder: (context, state) {
                return state.when(initial: () {
                  return InkWell(
                    onTap: () {
                      if (fieldController.text.isEmpty) {
                        setState(() {
                          fieldhasIssue = true;
                        });
                      } else {
                        setState(() {
                          fieldhasIssue = false;
                        });
                      }

                      if (!fieldhasIssue) {
                        context
                            .read<UpdatePayoutThresholdCubit>()
                            .updateThreshold(
                                int.parse(fieldController.text.toString()));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.white10,
                        period: const Duration(seconds: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Set Threshold',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: SvgPicture.asset(
                                  'assets/icons/forward_arrow.svg',
                                  color: Colors.white,
                                  fit: BoxFit.contain),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, loading: () {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF145DA0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.white10,
                      period: const Duration(seconds: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }, loaded: (m) {
                  return InkWell(
                    onTap: () {
                      if (fieldController.text.isEmpty) {
                        setState(() {
                          fieldhasIssue = true;
                        });
                      } else {
                        setState(() {
                          fieldhasIssue = false;
                        });
                      }

                      if (!fieldhasIssue) {
                        context
                            .read<UpdatePayoutThresholdCubit>()
                            .updateThreshold(
                                int.parse(fieldController.text.toString()));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.white10,
                        period: const Duration(seconds: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Set Threshold',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: SvgPicture.asset(
                                  'assets/icons/forward_arrow.svg',
                                  color: Colors.white,
                                  fit: BoxFit.contain),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, error: (m) {
                  return Container();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepOne extends StatelessWidget {
  const StepOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text('Payout Threshold',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          const Text(
            'Payout threshold allows you to accumulate ',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          const Text(
            'payout funds to save you transaction costs.',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: InkWell(
              onTap: () {
                context.read<ChangeThresholdWidgetCubit>().toogleWidget('', 1);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  color: Color(0xFF145DA0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.white10,
                  period: const Duration(seconds: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Activate Payout Threshold',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: SvgPicture.asset(
                            'assets/icons/forward_arrow.svg',
                            color: Colors.white,
                            fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
