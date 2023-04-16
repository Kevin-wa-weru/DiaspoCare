part of 'get_quotes_and_responses_cubit.dart';

@freezed
class GetQuotesAndResponsesState with _$GetQuotesAndResponsesState {
  const factory GetQuotesAndResponsesState.initial() = _Initial;
  const factory GetQuotesAndResponsesState.loading() = _Loading;
  const factory GetQuotesAndResponsesState.loaded(List quotes) = _Loaded;
  const factory GetQuotesAndResponsesState.error(String message) = _Error;
}
