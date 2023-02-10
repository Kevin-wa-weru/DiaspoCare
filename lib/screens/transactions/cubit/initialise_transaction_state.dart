part of 'initialise_transaction_cubit.dart';

@freezed
class InitialiseTransactionState with _$InitialiseTransactionState {
  const factory InitialiseTransactionState.initial() = _Initial;
  const factory InitialiseTransactionState.loading() = _Loading;
  const factory InitialiseTransactionState.loaded(String message) = _Loaded;
  const factory InitialiseTransactionState.error(String message) = _Error;
}
