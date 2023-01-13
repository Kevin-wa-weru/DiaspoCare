part of 'bank_details_cubit.dart';

@freezed
class BankDetailsState with _$BankDetailsState {
  const factory BankDetailsState.initial() = _Initial;
  const factory BankDetailsState.loading() = _Loading;
  const factory BankDetailsState.loaded(String result) = _Loaded;
  const factory BankDetailsState.error(String message) = _Error;
}
