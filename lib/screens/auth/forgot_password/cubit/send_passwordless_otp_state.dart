part of 'send_passwordless_otp_cubit.dart';

@freezed
class SendPasswordlessOtpState with _$SendPasswordlessOtpState {
  const factory SendPasswordlessOtpState.initial() = _Initial;
  const factory SendPasswordlessOtpState.loading() = _Loading;
  const factory SendPasswordlessOtpState.loaded(
      String result, String phoneNumber) = _Loaded;
  const factory SendPasswordlessOtpState.error(
    String message,
  ) = _Error;
}
