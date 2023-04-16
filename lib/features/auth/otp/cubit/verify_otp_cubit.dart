import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_otp_state.dart';
part 'verify_otp_cubit.freezed.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(const VerifyOtpState.initial());

  verifyOtp(otpCode, token) async {
    emit(const VerifyOtpState.loading());
    var response = await DiaspoCareAPis.verifyOtp(otpCode, token);

    if (response == 'Otp verified') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isPhoneVerified', true);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isPhoneVerified', false);
    }
    emit(VerifyOtpState.loaded(response));
  }
}
