part of 'payout_visible_cubit.dart';

@freezed
class PayoutVisibleState with _$PayoutVisibleState {
  const factory PayoutVisibleState.initial() = _Initial;
  const factory PayoutVisibleState.loading() = _Loading;
  const factory PayoutVisibleState.loaded(bool isVisible) = _Loaded;
  const factory PayoutVisibleState.error(String message) = _Error;
}
