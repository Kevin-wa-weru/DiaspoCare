import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/auth/bank_details/cubit/bank_names_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Select your bank',
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
          )
        ],
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
              }, loaded: (banks) {
                List bankNames = [];
                for (var b in banks) {
                  bankNames.add(b['name']);
                }

                bankNames.sort((a, b) {
                  return a.compareTo(b);
                });
                return Column(
                  children: bankNames
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.pop(
                              context,
                              e,
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
                                    e,
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
