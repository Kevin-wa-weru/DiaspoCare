part of 'bank_names_cubit.dart';

@freezed
class BankNamesState with _$BankNamesState {
  const factory BankNamesState.initial() = _Initial;
  const factory BankNamesState.loading() = _Loading;
  const factory BankNamesState.loaded(List banknames) = _Loaded;
  const factory BankNamesState.error(String message) = _Error;
}
