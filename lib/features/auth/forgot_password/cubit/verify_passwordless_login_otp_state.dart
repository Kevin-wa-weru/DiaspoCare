part of 'verify_passwordless_login_otp_cubit.dart';

@freezed
class VerifyPasswordlessLoginOtpState with _$VerifyPasswordlessLoginOtpState {
  const factory VerifyPasswordlessLoginOtpState.initial() = _Initial;
  const factory VerifyPasswordlessLoginOtpState.loading() = _Loading;
  const factory VerifyPasswordlessLoginOtpState.loaded(String result) = _Loaded;
  const factory VerifyPasswordlessLoginOtpState.error(String message) = _Error;
}
