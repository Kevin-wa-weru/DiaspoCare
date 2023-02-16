import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_dash_board_stats_state.dart';
part 'get_dash_board_stats_cubit.freezed.dart';

class GetDashBoardStatsCubit extends Cubit<GetDashBoardStatsState> {
  GetDashBoardStatsCubit() : super(const GetDashBoardStatsState.initial());

  getDashboardStats() async {
    emit(const GetDashBoardStatsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    String? facilityName = prefs.getString('facilityName');
    if (facilityName == null) {
    } else {
      var response =
          await DiaspoCareAPis.getDashboardStats(facilityName, token!);

      emit(GetDashBoardStatsState.loaded(response));
      return response;
    }
  }
}
