import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_passwordless_login_otp_state.dart';
part 'verify_passwordless_login_otp_cubit.freezed.dart';

class VerifyPasswordlessLoginOtpCubit
    extends Cubit<VerifyPasswordlessLoginOtpState> {
  VerifyPasswordlessLoginOtpCubit()
      : super(const VerifyPasswordlessLoginOtpState.initial());

  verifyOtp(otpCode, phoneNumber) async {
    emit(const VerifyPasswordlessLoginOtpState.loading());
    var response =
        await DiaspoCareAPis.verifyPasswordLessLoginOtp(otpCode, phoneNumber);

    emit(VerifyPasswordlessLoginOtpState.loaded(response));
  }
}
