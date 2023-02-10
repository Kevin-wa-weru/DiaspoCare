part of 'get_declined_transactions_cubit.dart';

@freezed
class GetDeclinedTransactionsState with _$GetDeclinedTransactionsState {
  const factory GetDeclinedTransactionsState.initial() = _Initial;
  const factory GetDeclinedTransactionsState.loading() = _Loading;
  const factory GetDeclinedTransactionsState.loaded(List declinedTransactions) =
      _Loaded;
  const factory GetDeclinedTransactionsState.error(String message) = _Error;
}
