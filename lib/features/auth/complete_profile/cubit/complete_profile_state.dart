part of 'complete_profile_cubit.dart';

@freezed
class CompleteProfileState with _$CompleteProfileState {
  const factory CompleteProfileState.initial() = _Initial;
  const factory CompleteProfileState.loading() = _Loading;
  const factory CompleteProfileState.loaded(String result) = _Loaded;
  const factory CompleteProfileState.error(String message) = _Error;
}
