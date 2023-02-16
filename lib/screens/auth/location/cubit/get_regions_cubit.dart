import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_regions_state.dart';
part 'get_regions_cubit.freezed.dart';

class GetRegionsCubit extends Cubit<GetRegionsState> {
  GetRegionsCubit() : super(const GetRegionsState.initial());

  getRegions(countryOfFacility) async {
    emit(const GetRegionsState.loading());
    var response = await DiaspoCareAPis.getRegions(countryOfFacility);
    emit(GetRegionsState.loaded(response));
  }
}
