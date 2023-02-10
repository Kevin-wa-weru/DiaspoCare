import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_regions_state.dart';
part 'get_regions_cubit.freezed.dart';

class GetRegionsCubit extends Cubit<GetRegionsState> {
  GetRegionsCubit() : super(const GetRegionsState.initial());

  getRegions(countryOfFacility) async {
    emit(const GetRegionsState.loading());
    var response = await DiaspoCareAPis.getRegions(countryOfFacility);
    print('Hello from REgions cubit');
    emit(GetRegionsState.loaded(response));
  }
}
