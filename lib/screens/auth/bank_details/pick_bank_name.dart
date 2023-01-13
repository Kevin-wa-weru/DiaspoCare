import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/auth/bank_details/cubit/bank_names_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickBankName extends StatefulWidget {
  const PickBankName({super.key});

  @override
  State<PickBankName> createState() => _PickBankNameState();
}

class _PickBankNameState extends State<PickBankName> {
  @override
  void initState() {
    // ignore: use_build_context_synchronously
    context.read<BankNamesCubit>().getBankNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // backgroundColor: primaryColor,
        backgroundColor: Colors.black54,
        elevation: 0,
        title: const Text('Select Your Bank'),
      ),
      body: ListView(
        children: [
          BlocBuilder<BankNamesCubit, BankNamesState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Container();
              }, loading: () {
                return const LinearProgressIndicator(
                  color: loadingButtonColor,
                );
              }, loaded: (message) {
                return Container();
              }, error: (message) {
                return Container();
              });
            },
          ),
          BlocBuilder<BankNamesCubit, BankNamesState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Container();
              }, loading: () {
                return Container();
              }, loaded: (bankNames) {
                return Column(
                  children: bankNames
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.pop(
                              context,
                              e['name'],
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, left: 15.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.6,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    e['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }, error: (message) {
                return Center(
                  child: Text(message.toString()),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
