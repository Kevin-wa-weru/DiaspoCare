part of 'get_quote_requests_cubit.dart';

@freezed
class GetQuoteRequestsState with _$GetQuoteRequestsState {
  const factory GetQuoteRequestsState.initial() = _Initial;
  const factory GetQuoteRequestsState.loading() = _Loading;
  const factory GetQuoteRequestsState.loaded(
      List quotes, List items, List localStorageRequests) = _Loaded;
  const factory GetQuoteRequestsState.error(String message) = _Error;
}
