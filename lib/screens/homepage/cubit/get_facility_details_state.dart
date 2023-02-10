part of 'get_facility_details_cubit.dart';

@freezed
class GetFacilityDetailsState with _$GetFacilityDetailsState {
  const factory GetFacilityDetailsState.initial() = _Initial;

  const factory GetFacilityDetailsState.loading() = _Loading;
  const factory GetFacilityDetailsState.loaded(
      Map<String, dynamic> facilityDetails) = _Loaded;
  const factory GetFacilityDetailsState.error(String message) = _Error;
}
