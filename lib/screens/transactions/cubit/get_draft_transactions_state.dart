part of 'get_draft_transactions_cubit.dart';

@freezed
class GetDraftTransactionsState with _$GetDraftTransactionsState {
  const factory GetDraftTransactionsState.initial() = _Initial;
  const factory GetDraftTransactionsState.loading() = _Loading;
  const factory GetDraftTransactionsState.loaded(List draftTransactions) =
      _Loaded;
  const factory GetDraftTransactionsState.error(String message) = _Error;
}
