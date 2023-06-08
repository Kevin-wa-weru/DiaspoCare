import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_payout_threshold_state.dart';
part 'update_payout_threshold_cubit.freezed.dart';

class UpdatePayoutThresholdCubit extends Cubit<UpdatePayoutThresholdState> {
  UpdatePayoutThresholdCubit()
      : super(const UpdatePayoutThresholdState.initial());

  updateThreshold(amount) async {
    emit(const UpdatePayoutThresholdState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');

    prefs.setBool('hasSetThreshold', true);

    var response = await DiaspoCareAPis.getPayoutThreshold(token);

    emit(UpdatePayoutThresholdState.loaded(amount.toString()));
  }
}
