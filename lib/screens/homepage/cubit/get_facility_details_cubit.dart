import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_facility_details_state.dart';
part 'get_facility_details_cubit.freezed.dart';

class GetFacilityDetailsCubit extends Cubit<GetFacilityDetailsState> {
  GetFacilityDetailsCubit() : super(const GetFacilityDetailsState.initial());

  getBankDetails() async {
    emit(const GetFacilityDetailsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('vendorName');
    var response = await DiaspoCareAPis.getFacilityDetails(token!);
    emit(GetFacilityDetailsState.loaded(response));
  }
}
