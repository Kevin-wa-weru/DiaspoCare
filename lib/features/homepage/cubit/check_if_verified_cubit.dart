import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'check_if_verified_state.dart';
part 'check_if_verified_cubit.freezed.dart';

class CheckIfVerifiedCubit extends Cubit<CheckIfVerifiedState> {
  CheckIfVerifiedCubit() : super(const CheckIfVerifiedState.initial());

  checkIfVerified() async {
    emit(const CheckIfVerifiedState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? facilityName = prefs.getString('facilityName');

    if (facilityName == null) {
    } else {
      var response = await DiaspoCareAPis.checkIfVeried(facilityName);

      emit(CheckIfVerifiedState.loaded(response));
    }
  }
}
