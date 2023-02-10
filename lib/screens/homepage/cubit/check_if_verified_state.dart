part of 'check_if_verified_cubit.dart';

@freezed
class CheckIfVerifiedState with _$CheckIfVerifiedState {
  const factory CheckIfVerifiedState.initial() = _Initial;
  const factory CheckIfVerifiedState.loading() = _Loading;
  const factory CheckIfVerifiedState.loaded(bool isVerified) = _Loaded;
  const factory CheckIfVerifiedState.error(String message) = _Error;
}
