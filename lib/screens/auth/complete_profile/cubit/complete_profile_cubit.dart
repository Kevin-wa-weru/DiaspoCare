import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_profile_state.dart';
part 'complete_profile_cubit.freezed.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(const CompleteProfileState.initial());

  completeProfile(
    email,
    facilityName,
    practitionerName,
    licenceNumber,
    countryCode,
    List<String> areasOfPractice,
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

    emit(const CompleteProfileState.loading());

    var response = await DiaspoCareAPis.createVendorProfile(email, facilityName,
        practitionerName, licenceNumber, countryName, currency, userToken);

    // await DiaspoCareAPis.assignTagToVendor(
    //   facilityName,
    //   areasOfPractice,
    //   userToken,
    // );

    emit(CompleteProfileState.loaded(response));
  }
}
