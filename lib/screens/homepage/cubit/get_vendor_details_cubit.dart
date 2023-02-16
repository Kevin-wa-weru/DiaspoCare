import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_vendor_details_state.dart';
part 'get_vendor_details_cubit.freezed.dart';

class GetVendorDetailsCubit extends Cubit<GetVendorDetailsState> {
  GetVendorDetailsCubit() : super(const GetVendorDetailsState.initial());

  getVendorDetails() async {
    emit(const GetVendorDetailsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vendorName = prefs.getString('vendorName');
    String? facilityName = prefs.getString('facilityName');
    if (facilityName == null) {
    } else {
      emit(GetVendorDetailsState.loaded({
        "vendorName": vendorName,
        "facilityName": facilityName,
      }));
    }
  }
}
