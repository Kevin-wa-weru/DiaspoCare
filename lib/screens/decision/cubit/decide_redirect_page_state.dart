part of 'decide_redirect_page_cubit.dart';

@freezed
class DecideRedirectPageState with _$DecideRedirectPageState {
  const factory DecideRedirectPageState.initial() = _Initial;
  const factory DecideRedirectPageState.loading() = _Loading;
  const factory DecideRedirectPageState.loaded(String redirectPage) = _Loaded;
  const factory DecideRedirectPageState.error(String message) = _Error;
}
