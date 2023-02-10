part of 'get_vendor_details_cubit.dart';

@freezed
class GetVendorDetailsState with _$GetVendorDetailsState {
  const factory GetVendorDetailsState.initial() = _Initial;
  const factory GetVendorDetailsState.loading() = _Loading;
  const factory GetVendorDetailsState.loaded(
      Map<String, dynamic> vendorDetails) = _Loaded;
  const factory GetVendorDetailsState.error(String message) = _Error;
}
