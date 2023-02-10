import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'decide_redirect_page_state.dart';
part 'decide_redirect_page_cubit.freezed.dart';

class DecideRedirectPageCubit extends Cubit<DecideRedirectPageState> {
  DecideRedirectPageCubit() : super(const DecideRedirectPageState.initial());

  decidePage() async {
    emit(const DecideRedirectPageState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var facilityName = prefs.getString('facilityName');

    var response = await DiaspoCareAPis.checkIfVeried(facilityName!);

    if (response == true) {
      emit(const DecideRedirectPageState.loaded('HomePage'));
    } else {
      var response = await DiaspoCareAPis.checkBankAccount(facilityName);

      if (response == true) {
        emit(const DecideRedirectPageState.loaded('ProfileComplete'));
      } else {
        emit(const DecideRedirectPageState.loaded('BankAccount'));
      }
    }
  }
}
