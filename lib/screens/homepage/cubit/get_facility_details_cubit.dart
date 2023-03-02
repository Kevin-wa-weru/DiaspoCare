import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_facility_details_state.dart';
part 'get_facility_details_cubit.freezed.dart';

class GetFacilityDetailsCubit extends Cubit<GetFacilityDetailsState> {
  GetFacilityDetailsCubit() : super(const GetFacilityDetailsState.initial());

  getFacilityDetails() async {
    emit(const GetFacilityDetailsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? facilityName = prefs.getString('facilityName');
    String? token = prefs.getString('userToken');
    var response =
        await DiaspoCareAPis.getFacilityDetails(facilityName!, token!);
    emit(GetFacilityDetailsState.loaded(response));
  }
}
