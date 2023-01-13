import 'package:diasporacare/screens/auth/bank_details/bank_details.dart';
import 'package:diasporacare/screens/auth/bank_details/cubit/bank_details_cubit.dart';
import 'package:diasporacare/screens/auth/bank_details/cubit/bank_names_cubit.dart';
import 'package:diasporacare/screens/auth/complete_profile/complete_profile.dart';
import 'package:diasporacare/screens/auth/complete_profile/profile_completed.dart';
import 'package:diasporacare/screens/auth/otp/cubit/cubit/get_phone_n_umber_cubit.dart';
import 'package:diasporacare/screens/auth/otp/cubit/verify_otp_cubit.dart';
import 'package:diasporacare/screens/auth/otp/verify_otp.dart';
import 'package:diasporacare/screens/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/country_switcher_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/sign_up.dart';
import 'package:diasporacare/screens/homepage/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/auth/complete_profile/cubit/complete_profile_cubit.dart';

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
        BlocProvider(
          create: (context) => CompleteProfileCubit(),
        ),
        BlocProvider(
          create: (context) => VerifyOtpCubit(),
        ),
        BlocProvider(
          create: (context) => BankDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => BankNamesCubit(),
        ),
        BlocProvider(
          create: (context) => GetPhoneNUmberCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diaspora Care',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // fontFamily: 'JosefinSans',
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: const CompleteProfile()),
    );
  }
}
