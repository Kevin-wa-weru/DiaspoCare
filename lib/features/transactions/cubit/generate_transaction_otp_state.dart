part of 'generate_transaction_otp_cubit.dart';

@freezed
class GenerateTransactionOtpState with _$GenerateTransactionOtpState {
  const factory GenerateTransactionOtpState.initial() = _Initial;
  const factory GenerateTransactionOtpState.loading() = _Loading;
  const factory GenerateTransactionOtpState.loaded(String message) = _Loaded;
  const factory GenerateTransactionOtpState.error(String message) = _Error;
}
