import 'package:diasporacare/screens/auth/bank_details/bank_details.dart';
import 'package:diasporacare/screens/auth/complete_profile/profile_completed.dart';
import 'package:diasporacare/screens/auth/sign_in/sign_in.dart';
import 'package:diasporacare/screens/decision/cubit/decide_redirect_page_cubit.dart';
import 'package:diasporacare/screens/homepage/home_screen.dart';
import 'package:diasporacare/screens/landing/landing_page.dart';
import 'package:diasporacare/screens/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesicionsPage extends StatefulWidget {
  const DesicionsPage({
    super.key,
  });

  @override
  State<DesicionsPage> createState() => _DesicionsPageState();
}

class _DesicionsPageState extends State<DesicionsPage> {
  @override
  void initState() {
    context.read<DecideRedirectPageCubit>().decidePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DecideRedirectPageCubit, DecideRedirectPageState>(
          listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            loaded: (message) {
              if (message == 'BankAccount') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BankDetails()));
              }

              if (message == 'ProfileComplete') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileComplete()));
              }

              if (message == 'HomePage') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            },
            error: (message) {});
      }, builder: (context, state) {
        return state.when(initial: () {
          return const Center(
            child: Spinner(heightOfSpinner: 50, widthofSpinnner: 50),
          );
        }, loading: () {
          return const Center(
            child: Spinner(heightOfSpinner: 50, widthofSpinnner: 50),
          );
        }, loaded: (message) {
          return const Center(
            child: Spinner(heightOfSpinner: 50, widthofSpinnner: 50),
          );
        }, error: (message) {
          return const Center(
            child: Spinner(heightOfSpinner: 50, widthofSpinnner: 50),
          );
        });
      }),
    );
  }
}
