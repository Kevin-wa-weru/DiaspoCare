import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bank_details_state.dart';
part 'bank_details_cubit.freezed.dart';

class BankDetailsCubit extends Cubit<BankDetailsState> {
  BankDetailsCubit() : super(const BankDetailsState.initial());

  saveBankDetails(bankName, accountHolderName, accountNumber) async {
    emit(const BankDetailsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('userPhoneNumber');

    var result = await DiaspoCareAPis.addBankAccount(
      bankName,
      accountHolderName,
      accountNumber,
      phone,
    );

    print('Results in cubit after sending bank details to API');
    print(result);

    emit(BankDetailsState.loaded(result));
  }
}
