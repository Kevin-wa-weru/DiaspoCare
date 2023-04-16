part of 'verify_transaction_otp_cubit.dart';

@freezed
class VerifyTransactionOtpState with _$VerifyTransactionOtpState {
  const factory VerifyTransactionOtpState.initial() = _Initial;
  const factory VerifyTransactionOtpState.loading() = _Loading;
  const factory VerifyTransactionOtpState.loaded(Map<String, dynamic> message) =
      _Loaded;
  const factory VerifyTransactionOtpState.error(String message) = _Error;
}
