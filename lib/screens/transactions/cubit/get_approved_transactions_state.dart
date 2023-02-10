part of 'get_approved_transactions_cubit.dart';

@freezed
class GetApprovedTransactionsState with _$GetApprovedTransactionsState {
  const factory GetApprovedTransactionsState.initial() = _Initial;
  const factory GetApprovedTransactionsState.loading() = _Loading;
  const factory GetApprovedTransactionsState.loaded(List approvedTransactions) =
      _Loaded;
  const factory GetApprovedTransactionsState.error(String message) = _Error;
}
