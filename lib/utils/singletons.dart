part of diaspocare_utils;

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(),
        ),
        BlocProvider<CountrySwitcherCubit>(
          create: (context) => CountrySwitcherCubit(),
        ),
        BlocProvider<CompleteProfileCubit>(
          create: (context) => CompleteProfileCubit(),
        ),
        BlocProvider<VerifyOtpCubit>(
          create: (context) => VerifyOtpCubit(),
        ),
        BlocProvider<BankDetailsCubit>(
          create: (context) => BankDetailsCubit(),
        ),
        BlocProvider<BankNamesCubit>(
          create: (context) => BankNamesCubit(),
        ),
        BlocProvider<GetPhoneNUmberCubit>(
          create: (context) => GetPhoneNUmberCubit(),
        ),
        BlocProvider<GetRegionsCubit>(
          create: (context) => GetRegionsCubit(),
        ),
        BlocProvider<GetTownsCubit>(
          create: (context) => GetTownsCubit(),
        ),
        BlocProvider<AssignTagCubit>(
          create: (context) => AssignTagCubit(),
        ),
        BlocProvider<GetDraftTransactionsCubit>(
            create: (context) => GetDraftTransactionsCubit()),
        BlocProvider<GetApprovedTransactionsCubit>(
          create: (context) => GetApprovedTransactionsCubit(),
        ),
        BlocProvider<GetPendingTransactionsCubit>(
          create: (context) => GetPendingTransactionsCubit(),
        ),
        BlocProvider<GetDeclinedTransactionsCubit>(
          create: (context) => GetDeclinedTransactionsCubit(),
        ),
        BlocProvider<GetAccoutDetailsCubit>(
            create: (context) => GetAccoutDetailsCubit()),
        BlocProvider<GetFacilityDetailsCubit>(
            create: (context) => GetFacilityDetailsCubit()),
        BlocProvider<GetBankDetailsCubit>(
            create: (context) => GetBankDetailsCubit()),
        BlocProvider<GetDiscountsCubit>(
            create: (context) => GetDiscountsCubit()),
        BlocProvider<AddDiscountCubit>(create: (context) => AddDiscountCubit()),
        BlocProvider<EditDiscountCubit>(
            create: (context) => EditDiscountCubit()),
        BlocProvider<SearchBeneficiaryCubit>(
            create: (context) => SearchBeneficiaryCubit()),
        BlocProvider<AddBasketCubit>(create: (context) => AddBasketCubit()),
        BlocProvider<AddBasketItemCubit>(
            create: (context) => AddBasketItemCubit()),
        BlocProvider<GetBasketItemsCubit>(
            create: (context) => GetBasketItemsCubit()),
        BlocProvider<SearchItemsCubit>(create: (context) => SearchItemsCubit()),
        BlocProvider<GenerateTransactionOtpCubit>(
            create: (context) => GenerateTransactionOtpCubit()),
        BlocProvider<VerifyTransactionOtpCubit>(
            create: (context) => VerifyTransactionOtpCubit()),
        BlocProvider<InitialiseTransactionCubit>(
            create: (context) => InitialiseTransactionCubit()),
        BlocProvider<EditBasketItemCubit>(
            create: (context) => EditBasketItemCubit()),
        BlocProvider<UpdateLocationCubit>(
            create: (context) => UpdateLocationCubit()),
        BlocProvider<CheckIfVerifiedCubit>(
            create: (context) => CheckIfVerifiedCubit()),
        BlocProvider<GetVendorDetailsCubit>(
            create: (context) => GetVendorDetailsCubit()),
        BlocProvider<DecideRedirectPageCubit>(
            create: (context) => DecideRedirectPageCubit()),
        BlocProvider<GetBestSellingItemsCubit>(
            create: (context) => GetBestSellingItemsCubit()),
        BlocProvider<GetDashBoardStatsCubit>(
            create: (context) => GetDashBoardStatsCubit()),
        BlocProvider<SignInTwoCubit>(create: (context) => SignInTwoCubit()),
        BlocProvider<SendPasswordlessOtpCubit>(
            create: (context) => SendPasswordlessOtpCubit()),
        BlocProvider<VerifyPasswordlessLoginOtpCubit>(
            create: (context) => VerifyPasswordlessLoginOtpCubit()),
        BlocProvider<GetQuoteRequestsCubit>(
            create: (context) => GetQuoteRequestsCubit()),
        BlocProvider<RespondToQuoteCubit>(
            create: (context) => RespondToQuoteCubit()),
        BlocProvider<GetBasketDetailsCubit>(
            create: (context) => GetBasketDetailsCubit()),
        BlocProvider<QuoteBasketItemCubit>(
            create: (context) => QuoteBasketItemCubit()),
        BlocProvider<GetNewRequestCountCubit>(
            create: (context) => GetNewRequestCountCubit()),
        BlocProvider<GetQuotesAndResponsesCubit>(
            create: (context) => GetQuotesAndResponsesCubit()),
      ];
}
