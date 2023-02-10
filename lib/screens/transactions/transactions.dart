import 'package:diasporacare/constants.dart';
import 'package:diasporacare/models/transaction_type.dart';
import 'package:diasporacare/screens/homepage/cubit/get_discounts_cubit.dart';
import 'package:diasporacare/screens/transactions/adding_to_basket.dart';

import 'package:diasporacare/screens/transactions/cubit/get_approved_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_declined_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_draft_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_pending_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/edit_basket_item.dart';
import 'package:diasporacare/screens/transactions/request_for_payment.dart';
import 'package:diasporacare/screens/transactions/search_beneficiary.dart';
import 'package:diasporacare/screens/widgets/loading_container_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<TransactionType> transactionTypes = [
    TransactionType(Colors.orange, 'Pending'),
    TransactionType(Colors.green, 'Approved'),
    TransactionType(Colors.red, 'Declined')
  ];

  List<String> discounts = [];

  @override
  void initState() {
    context.read<GetDraftTransactionsCubit>().getDraftTransaction();
    context.read<GetPendingTransactionsCubit>().getPendingTransaction();
    context.read<GetApprovedTransactionsCubit>().getApprovedTransaction();
    context.read<GetDeclinedTransactionsCubit>().getDeclinedTransaction();
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

  Widget resolveBodyOfTransaction(
      String transactionType, Color transactionColor) {
    if (transactionType == 'Pending') {
      return BlocBuilder<GetPendingTransactionsCubit,
          GetPendingTransactionsState>(
        builder: (context, state) {
          return state.when(initial: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loading: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loaded: (List pendingTransactions) {
            return Column(
                children: pendingTransactions
                    .map((singleTransaction) => SingleTransaction(
                        transactionColor: transactionColor,
                        singleTransaction: singleTransaction))
                    .toList());
          }, error: (error) {
            return Text(error);
          });
        },
      );
    }

    if (transactionType == 'Approved') {
      return BlocBuilder<GetApprovedTransactionsCubit,
          GetApprovedTransactionsState>(
        builder: (context, state) {
          return state.when(initial: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loading: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loaded: (List approvedTransactions) {
            return Column(
                children: approvedTransactions
                    .map((singleTransaction) => SingleTransaction(
                        transactionColor: transactionColor,
                        singleTransaction: singleTransaction))
                    .toList());
          }, error: (error) {
            return Text(error);
          });
        },
      );
    }

    if (transactionType == 'Declined') {
      return BlocBuilder<GetDeclinedTransactionsCubit,
          GetDeclinedTransactionsState>(
        builder: (context, state) {
          return state.when(initial: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loading: () {
            return Column(
                children: transactionTypes
                    .map(
                        (singleTransaction) => const SingleLoadingTransaction())
                    .toList());
          }, loaded: (List approvedTransactions) {
            return Column(
                children: approvedTransactions
                    .map((singleTransaction) => SingleTransaction(
                        transactionColor: transactionColor,
                        singleTransaction: singleTransaction))
                    .toList());
          }, error: (error) {
            return Text(error);
          });
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Transactions',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          BlocBuilder<GetDraftTransactionsCubit, GetDraftTransactionsState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.57,
                        decoration: const BoxDecoration(
                          color: loadingButtonColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: SvgPicture.asset('assets/icons/bill.svg',
                                    color: Colors.white54, fit: BoxFit.contain),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 4.0,
                              ),
                              child: Text(
                                'Create New Order',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: SvgPicture.asset(
                                  'assets/icons/forward_arrow.svg',
                                  color: Colors.white54,
                                  fit: BoxFit.contain),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, loading: () {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.57,
                        decoration: const BoxDecoration(
                          color: loadingButtonColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: SvgPicture.asset('assets/icons/bill.svg',
                                    color: Colors.white54, fit: BoxFit.contain),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 4.0,
                              ),
                              child: Text(
                                'Create New Order',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: SvgPicture.asset(
                                  'assets/icons/forward_arrow.svg',
                                  color: Colors.white54,
                                  fit: BoxFit.contain),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, loaded: (m) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchBeneficiary(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.57,
                          decoration: BoxDecoration(
                            color: const Color(0xFF145DA0),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: SvgPicture.asset(
                                      'assets/icons/bill.svg',
                                      color: Colors.white,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: Text(
                                  'Create New Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: SvgPicture.asset(
                                    'assets/icons/forward_arrow.svg',
                                    color: Colors.white,
                                    fit: BoxFit.contain),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, error: (message) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchBeneficiary(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.57,
                          decoration: BoxDecoration(
                            color: const Color(0xFF145DA0),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: SvgPicture.asset(
                                      'assets/icons/bill.svg',
                                      color: Colors.white,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: Text(
                                  'Create New Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: SvgPicture.asset(
                                    'assets/icons/forward_arrow.svg',
                                    color: Colors.white,
                                    fit: BoxFit.contain),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ExpansionPanelList.radio(
              dividerColor: Colors.black54,
              animationDuration: const Duration(milliseconds: 700),
              elevation: 0,
              children: transactionTypes.map((singleTransactionType) {
                return ExpansionPanelRadio(
                  canTapOnHeader: true,
                  backgroundColor: Colors.transparent,
                  value: singleTransactionType.transactionType,
                  body: resolveBodyOfTransaction(
                      singleTransactionType.transactionType,
                      singleTransactionType.transactionColor),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return BlocBuilder<GetDraftTransactionsCubit,
                        GetDraftTransactionsState>(
                      builder: (context, state) {
                        return state.when(initial: () {
                          return ListTile(
                            iconColor: Colors.black12,
                            leading: Transform.translate(
                              offset: const Offset(0.0, 5.0),
                              child: Container(
                                height: 11,
                                width: 11,
                                decoration: BoxDecoration(
                                  color: singleTransactionType.transactionColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                            ),
                            title: Transform.translate(
                              offset: const Offset(-30.0, 0.0),
                              child: Row(
                                children: [
                                  Text(singleTransactionType.transactionType,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          );
                        }, loading: () {
                          return ListTile(
                            iconColor: Colors.black12,
                            leading: Transform.translate(
                              offset: const Offset(0.0, 5.0),
                              child: Container(
                                height: 11,
                                width: 11,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                            ),
                            title: Transform.translate(
                              offset: const Offset(-30.0, 0.0),
                              child: Row(
                                children: [
                                  LoadingContainerAnimation(
                                    targetContainer: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }, loaded: (m) {
                          return ListTile(
                            iconColor: Colors.black,
                            leading: Transform.translate(
                              offset: const Offset(0.0, 5.0),
                              child: Container(
                                height: 11,
                                width: 11,
                                decoration: BoxDecoration(
                                  color: singleTransactionType.transactionColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                            ),
                            title: Transform.translate(
                              offset: const Offset(-30.0, 0.0),
                              child: Row(
                                children: [
                                  Text(singleTransactionType.transactionType,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          );
                        }, error: (m) {
                          return ListTile(
                            iconColor: Colors.black,
                            leading: Transform.translate(
                              offset: const Offset(0.0, 5.0),
                              child: Container(
                                height: 11,
                                width: 11,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                            ),
                            title: Transform.translate(
                              offset: const Offset(-30.0, 0.0),
                              child: Row(
                                children: [
                                  Text(singleTransactionType.transactionType,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: BlocBuilder<GetDraftTransactionsCubit,
                    GetDraftTransactionsState>(
                  builder: (context, state) {
                    return state.when(initial: () {
                      return const Text(
                        'Draft Transactions',
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      );
                    }, loading: () {
                      return const Text(
                        'Draft Transactions',
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      );
                    }, loaded: (n) {
                      return const Text(
                        'Draft Transactions',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      );
                    }, error: (n) {
                      return const Text(
                        'Draft Transactions',
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SingleChildScrollView(
            child: BlocBuilder<GetDraftTransactionsCubit,
                GetDraftTransactionsState>(
              builder: (context, state) {
                return state.when(initial: () {
                  return Column(
                      children: transactionTypes
                          .map((singleTransaction) =>
                              const SingleDraftTransactionLoading())
                          .toList());
                }, loading: () {
                  return Column(
                      children: transactionTypes
                          .map((singleTransaction) =>
                              const SingleDraftTransactionLoading())
                          .toList());
                }, loaded: (List draftTransactions) {
                  // return Column(
                  //     children: transactionTypes
                  //         .map((singleTransaction) =>
                  //             const SingleDraftTransactionLoading())
                  //         .toList());
                  return Column(
                      children: draftTransactions
                          .map((singleTransaction) => SingleDraftTransaction(
                                singleDraftTransaction: singleTransaction,
                                discount: discounts,
                              ))
                          .toList());
                }, error: (error) {
                  return Text(error);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class SingleTransaction extends StatelessWidget {
  const SingleTransaction({
    Key? key,
    required this.transactionColor,
    required this.singleTransaction,
  }) : super(key: key);
  final Color transactionColor;
  final Map<String, dynamic> singleTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.translate(
                            offset: const Offset(0.0, 0.0),
                            child: Container(
                              height: 9,
                              width: 9,
                              decoration: BoxDecoration(
                                color: transactionColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              singleTransaction['basket']['name'],
                              style: const TextStyle(
                                  color: Color(0xFF145DA0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          '${singleTransaction['items_count']} items for ${singleTransaction['items_price']}',
                          style: const TextStyle(
                              color: Color(0xFF145DA0),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${Jiffy(DateTime.parse(singleTransaction['basket']['created'])).format(' do MMM yyyy')}, ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${DateTime.parse(singleTransaction['basket']['created']).hour}:${DateTime.parse(singleTransaction['basket']['created']).minute}:${DateTime.parse(singleTransaction['basket']['created']).second.round()}"))}',
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 2),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Beneficiary:",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 2),
                  child: Row(
                    children: [
                      Text(
                        singleTransaction['basket']['beneficiary'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SingleLoadingTransaction extends StatelessWidget {
  const SingleLoadingTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.translate(
                            offset: const Offset(0.0, 0.0),
                            child: Container(
                              height: 9,
                              width: 9,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: LoadingContainerAnimation(
                                targetContainer: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 5.0),
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
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 2),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Beneficiary:",
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 2),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SingleDraftTransaction extends StatelessWidget {
  const SingleDraftTransaction({
    Key? key,
    required this.singleDraftTransaction,
    required this.discount,
  }) : super(key: key);
  final List<String> discount;

  final Map<String, dynamic> singleDraftTransaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
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
                  child: Text(
                    singleDraftTransaction['basket']['name'],
                    style: const TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                  child: Text(
                    '${singleDraftTransaction['items_count']} items for ${singleDraftTransaction['items_price']}',
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
                    '${Jiffy(DateTime.parse(singleDraftTransaction['basket']['created'])).format(' do MMM yyyy')}, ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${DateTime.parse(singleDraftTransaction['basket']['created']).hour}:${DateTime.parse(singleDraftTransaction['basket']['created']).minute}:${DateTime.parse(singleDraftTransaction['basket']['created']).second.round()}"))}',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 5),
                  child: Text(
                    singleDraftTransaction['basket']['beneficiary'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddingToBssket(
                                  basketDetails:
                                      singleDraftTransaction['basket'],
                                  initialDropdownValue: discount[0],
                                  discounts: discount,
                                  beneficiaryName:
                                      singleDraftTransaction['basket']
                                          ['beneficiary'])));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        border: Border.all(
                          color: const Color(0xFF145DA0),
                          width: 1.0,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Edit Order',
                          style: TextStyle(
                              color: Color(0xFF145DA0),
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestPayment(
                              basketDetails: singleDraftTransaction['basket'],
                              beneficiaryName: singleDraftTransaction['basket']
                                  ['beneficiary'],
                              totalAmount: singleDraftTransaction['items_price']
                                  .toString(),
                            ),
                          ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF145DA0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Request Payment',
                          style: TextStyle(
                              color: Colors.white,
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
    );
  }
}

class SingleDraftTransactionLoading extends StatelessWidget {
  const SingleDraftTransactionLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(
            color: Colors.black12,
            width: 0.2,
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
                      child: LoadingContainerAnimation(
                          targetContainer: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ))),
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 10.0),
                      child: LoadingContainerAnimation(
                          targetContainer: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ))),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 0.2),
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 14, top: 5),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
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
    );
  }
}
