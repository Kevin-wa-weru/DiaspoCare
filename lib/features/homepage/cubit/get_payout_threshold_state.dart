part of 'get_payout_threshold_cubit.dart';

@freezed
class GetPayoutThresholdState with _$GetPayoutThresholdState {
  const factory GetPayoutThresholdState.initial() = _Initial;
  const factory GetPayoutThresholdState.loading() = _Loading;
  const factory GetPayoutThresholdState.loaded(
      String amount, bool isVisible, bool hasSetThreshold) = _Loaded;
  const factory GetPayoutThresholdState.error(String message) = _Error;
}
