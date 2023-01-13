part of 'verify_otp_cubit.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial() = _Initial;
  const factory VerifyOtpState.loading() = _Loading;
  const factory VerifyOtpState.loaded(String result) = _Loaded;
  const factory VerifyOtpState.error(String message) = _Error;
}
