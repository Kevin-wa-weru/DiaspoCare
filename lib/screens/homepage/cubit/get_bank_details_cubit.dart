import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_bank_details_state.dart';
part 'get_bank_details_cubit.freezed.dart';

class GetBankDetailsCubit extends Cubit<GetBankDetailsState> {
  GetBankDetailsCubit() : super(const GetBankDetailsState.initial());

  getBankDetails() async {
    emit(const GetBankDetailsState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');

    var response = await DiaspoCareAPis.getBankDetails(token!);

    emit(GetBankDetailsState.loaded(response));
  }
}
