import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'send_passwordless_otp_state.dart';
part 'send_passwordless_otp_cubit.freezed.dart';

class SendPasswordlessOtpCubit extends Cubit<SendPasswordlessOtpState> {
  SendPasswordlessOtpCubit() : super(const SendPasswordlessOtpState.initial());

  sendOtp(phoneNumber) async {
    emit(const SendPasswordlessOtpState.loading());
    late String fullNumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var code = prefs.getString('countryCode');

    if (code == "ke") {
      fullNumber = '+254$phoneNumber';
    }

    if (code == "ng") {
      fullNumber = '+234$phoneNumber';
    }

    if (code == "gh") {
      fullNumber = '+233$phoneNumber';
    }

    if (code == "ug") {
      fullNumber = '+256$phoneNumber';
    }

    var response = await DiaspoCareAPis.sendPasswordlessLoginOtp(fullNumber);
    emit(SendPasswordlessOtpState.loaded(response, fullNumber));
  }
}
