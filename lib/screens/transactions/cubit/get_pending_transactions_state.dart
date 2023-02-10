part of 'get_pending_transactions_cubit.dart';

@freezed
class GetPendingTransactionsState with _$GetPendingTransactionsState {
  const factory GetPendingTransactionsState.initial() = _Initial;
  const factory GetPendingTransactionsState.loading() = _Loading;
  const factory GetPendingTransactionsState.loaded(List pendingTransactions) =
      _Loaded;
  const factory GetPendingTransactionsState.error(String message) = _Error;
}
