part of 'sign_in_two_cubit.dart';

@freezed
class SignInTwoState with _$SignInTwoState {
  const factory SignInTwoState.initial() = _Initial;
  const factory SignInTwoState.loading() = _Loading;
  const factory SignInTwoState.loaded(String result) = _Loaded;
  const factory SignInTwoState.error(String message) = _Error;
}
