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
    countryCode,
    // List<String> areasOfPractice,
    userToken,
  ) async {
    late String countryName = '';
    late String currency = '';

    if (countryCode == 'ke') {
      countryName = 'Kenya';
      currency = 'KES';
    } else if (countryCode == 'ng') {
      countryName = 'Nigeria';
      currency = "NGN";
    } else {
      countryName = 'Ghana';
      currency = "GH";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');

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
