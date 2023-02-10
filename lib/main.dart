import 'package:diasporacare/screens/auth/bank_details/cubit/bank_details_cubit.dart';
import 'package:diasporacare/screens/auth/bank_details/cubit/bank_names_cubit.dart';
import 'package:diasporacare/screens/auth/complete_profile/cubit/assign_tag_cubit.dart';
import 'package:diasporacare/screens/auth/location/cubit/get_regions_cubit.dart';
import 'package:diasporacare/screens/auth/location/cubit/get_towns_cubit.dart';
import 'package:diasporacare/screens/auth/location/cubit/update_location_cubit.dart';
import 'package:diasporacare/screens/auth/location/update_location.dart';
import 'package:diasporacare/screens/auth/otp/cubit/cubit/get_phone_n_umber_cubit.dart';
import 'package:diasporacare/screens/auth/otp/cubit/verify_otp_cubit.dart';
import 'package:diasporacare/screens/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:diasporacare/screens/auth/sign_in/sign_in.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/country_switcher_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/sign_up.dart';
import 'package:diasporacare/screens/decision/cubit/decide_redirect_page_cubit.dart';
import 'package:diasporacare/screens/decision/custom_splash_screen.dart';
import 'package:diasporacare/screens/decision/desicion.dart';
import 'package:diasporacare/screens/homepage/cubit/add_discount_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/check_if_verified_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/edit_discount_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_accout_details_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_bank_details_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_best_selling_items_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_discounts_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_facility_details_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_vendor_details_cubit.dart';
import 'package:diasporacare/screens/landing/landing_page.dart';
import 'package:diasporacare/screens/transactions/cubit/add_basket_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/add_basket_item_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/edit_basket_item_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/generate_transaction_otp_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_approved_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_basket_items_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_declined_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_draft_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/get_pending_transactions_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/initialise_transaction_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/search_beneficiary_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/search_items_cubit.dart';
import 'package:diasporacare/screens/transactions/cubit/verify_transaction_otp_cubit.dart';
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
        BlocProvider(
          create: (context) => GetRegionsCubit(),
        ),
        BlocProvider(
          create: (context) => GetTownsCubit(),
        ),
        BlocProvider(
          create: (context) => AssignTagCubit(),
        ),
        BlocProvider(create: (context) => GetDraftTransactionsCubit()),
        BlocProvider(
          create: (context) => GetApprovedTransactionsCubit(),
        ),
        BlocProvider(
          create: (context) => GetPendingTransactionsCubit(),
        ),
        BlocProvider(
          create: (context) => GetDeclinedTransactionsCubit(),
        ),
        BlocProvider(create: (context) => GetAccoutDetailsCubit()),
        BlocProvider(create: (context) => GetFacilityDetailsCubit()),
        BlocProvider(create: (context) => GetBankDetailsCubit()),
        BlocProvider(create: (context) => GetDiscountsCubit()),
        BlocProvider(create: (context) => AddDiscountCubit()),
        BlocProvider(create: (context) => EditDiscountCubit()),
        BlocProvider(create: (context) => SearchBeneficiaryCubit()),
        BlocProvider(create: (context) => AddBasketCubit()),
        BlocProvider(create: (context) => AddBasketItemCubit()),
        BlocProvider(create: (context) => GetBasketItemsCubit()),
        BlocProvider(create: (context) => SearchItemsCubit()),
        BlocProvider(create: (context) => GenerateTransactionOtpCubit()),
        BlocProvider(create: (context) => VerifyTransactionOtpCubit()),
        BlocProvider(create: (context) => InitialiseTransactionCubit()),
        BlocProvider(create: (context) => EditBasketItemCubit()),
        BlocProvider(create: (context) => UpdateLocationCubit()),
        BlocProvider(create: (context) => CheckIfVerifiedCubit()),
        BlocProvider(create: (context) => GetVendorDetailsCubit()),
        BlocProvider(create: (context) => DecideRedirectPageCubit()),
        BlocProvider(create: (context) => GetBestSellingItemsCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DiaspoCare',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          // ignore: prefer_const_constructors
          home: CustomSplashScreen()),
    );
  }
}
