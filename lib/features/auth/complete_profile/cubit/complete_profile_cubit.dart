import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'complete_profile_state.dart';
part 'complete_profile_cubit.freezed.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(const CompleteProfileState.initial());

  completeProfile(
    // email,
    facilityName,
    practitionerName,
    licenceNumber,
    // countryCode,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? countryCode = prefs.getString('countryCode');

    late String countryName = '';
    late String currency = '';

    if (countryCode == 'ke') {
      countryName = 'Kenya';
      currency = 'KES';
    } else if (countryCode == 'ng') {
      countryName = 'Nigeria';
      currency = "NGN";
    } else if (countryCode == 'gh') {
      countryName = 'Ghana';
      currency = "GHS";
    } else {
      countryName = 'Uganda';
      currency = "UGX";
    }

    String? userEmail = prefs.getString('userEmail');
    String? userToken = prefs.getString('userToken');

    emit(const CompleteProfileState.loading());

    var response = await DiaspoCareAPis.createVendorProfile(
        userEmail,
        facilityName,
        practitionerName,
        licenceNumber,
        countryName,
        currency,
        userToken);

    // await DiaspoCareAPis.assignTagToVendor(
    //   facilityName,
    //   areasOfPractice,
    //   userToken,
    // );

    prefs.setString('countryOfFacility', countryName);
    prefs.setString('facilityName', facilityName);

    if (response == 'Profile has been updated') {
      prefs.setBool('isProfileComplete', true);
    } else {
      prefs.setBool('isProfileComplete', false);
    }
    emit(CompleteProfileState.loaded(response));
  }
}
