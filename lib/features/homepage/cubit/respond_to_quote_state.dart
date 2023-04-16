part of 'respond_to_quote_cubit.dart';

@freezed
class RespondToQuoteState with _$RespondToQuoteState {
  const factory RespondToQuoteState.initial(List localStorage) = _Initial;
  const factory RespondToQuoteState.loading() = _Loading;
  const factory RespondToQuoteState.loaded(
      Map<String, dynamic> response, String requestId) = _Loaded;
  const factory RespondToQuoteState.error(String message) = _Error;
}
