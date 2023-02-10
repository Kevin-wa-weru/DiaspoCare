import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_location_state.dart';
part 'update_location_cubit.freezed.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  UpdateLocationCubit() : super(const UpdateLocationState.initial());

  updateLocation(String district, String region, String description) async {
    emit(const UpdateLocationState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.updateLocation(
        token!, district, region, description);
    emit(UpdateLocationState.loaded(response));
  }
}
