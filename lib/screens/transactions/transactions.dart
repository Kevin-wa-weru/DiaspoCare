import 'package:diasporacare/models/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<TransactionType> transactionTypes = [
    TransactionType(Colors.yellow, 'Pending'),
    TransactionType(Colors.green, 'Approved'),
    TransactionType(Colors.red, 'Declined')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Transactions',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.55,
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
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: SvgPicture.asset('assets/icons/bill.svg',
                              color: Colors.white, fit: BoxFit.contain),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Create New Order',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
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
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ExpansionPanelList.radio(
              dividerColor: Colors.black54,
              elevation: 0,
              children: transactionTypes.map((singleTransactionType) {
                return ExpansionPanelRadio(
                  canTapOnHeader: true,
                  backgroundColor: Colors.transparent,
                  value: singleTransactionType.transactionType,
                  body: Container(),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      iconColor: Colors.black,
                      leading: Transform.translate(
                        offset: const Offset(0.0, 5.0),
                        child: Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            color: singleTransactionType.transactionColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
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
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Draft Transactions',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Expanded(
              child: ListView(
            children: [
              Column(
                  children: transactionTypes
                      .map((e) => const SingleDraftTransaction())
                      .toList()),
            ],
          ))
        ],
      ),
    );
  }
}

class SingleDraftTransaction extends StatelessWidget {
  const SingleDraftTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.21,
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
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15),
                  child: Text(
                    'a2h4bu34c',
                    style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0, top: 10.0),
                  child: Text(
                    '12 items for 2,890',
                    style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 14,
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
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    '26th October 2022, 13:56:34 am',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 14, top: 5),
                  child: Text(
                    'Jeremy CruickShank',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
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
