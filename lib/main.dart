import 'package:diasporacare/screens/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:diasporacare/screens/auth/sign_in/sign_in.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/country_switcher_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => CountrySwitcherCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DiaspoCare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'JosefinSans',
        ),
        home: const SignUp(),
      ),
    );
  }
}
