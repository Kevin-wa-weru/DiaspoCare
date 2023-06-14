import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_payout_threshold_state.dart';
part 'get_payout_threshold_cubit.freezed.dart';

class GetPayoutThresholdCubit extends Cubit<GetPayoutThresholdState> {
  GetPayoutThresholdCubit() : super(const GetPayoutThresholdState.initial());

  changeVisibility(amount, bool isVisible) async {
    emit(const GetPayoutThresholdState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('payoutVisible', isVisible);
    bool? visiblity = prefs.getBool('payoutVisible');
    bool? hasSetThreshold = prefs.getBool('hasSetThreshold');

    if (hasSetThreshold == null || hasSetThreshold == false) {
      emit(GetPayoutThresholdState.loaded(amount, visiblity!, false));
    } else {
      emit(GetPayoutThresholdState.loaded(amount, visiblity!, true));
    }
  }

  getPayoutThreshold(bool isVisible) async {
    print(
      'Started getting payout threshold',
    );
    emit(const GetPayoutThresholdState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('payoutVisible', isVisible);
    bool? visiblity = prefs.getBool('payoutVisible');
    String? token = prefs.getString('userToken');

    bool? hasSetThreshold = prefs.getBool('hasSetThreshold');

    var response = await DiaspoCareAPis.getPayoutThreshold(
      token,
    );

    if (hasSetThreshold == null || hasSetThreshold == false) {
      emit(GetPayoutThresholdState.loaded(
          response.toString(), visiblity!, false));
    } else {
      emit(GetPayoutThresholdState.loaded(
          response.toString(), visiblity!, true));
    }
  }
}
