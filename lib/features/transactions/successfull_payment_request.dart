import 'package:diasporacare/features/homepage/home_screen.dart';
import 'package:diasporacare/features/transactions/cubit/get_draft_transactions_cubit.dart';
import 'package:diasporacare/features/transactions/cubit/initialise_transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfullRequest extends StatefulWidget {
  const SuccessfullRequest(
      {super.key, required this.basketDetails, required this.secureCode});
  final Map<String, dynamic> basketDetails;
  final String secureCode;
  @override
  State<SuccessfullRequest> createState() => _SuccessfullRequestState();
}

class _SuccessfullRequestState extends State<SuccessfullRequest> {
  @override
  void initState() {
    print('INitial state in SuccessfullPayment ');
    print(widget.basketDetails['name']);
    print(widget.secureCode);
    context
        .read<InitialiseTransactionCubit>()
        .initialiseTransaction(widget.basketDetails['name'], widget.secureCode);

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
          'Request for payment',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body:
          BlocConsumer<InitialiseTransactionCubit, InitialiseTransactionState>(
        listener: (context, state) {
          state.when(
              initial: () {},
              loading: () {},
              loaded: (message) {
                Future.delayed(const Duration(seconds: 2), () {
                  context
                      .read<GetDraftTransactionsCubit>()
                      .getDraftTransaction();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HomeScreen()));
                });
              },
              error: (message) {});
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SvgPicture.asset(
                    'assets/icons/success_tick.svg',
                    color: const Color(0xFF0F9D58),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                "Transaction has been",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F9D58),
                ),
              ),
              const Text(
                "successfully initialized",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F9D58),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const Text(
                'Redirecting back to transaction list . . .',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );
  }
}
