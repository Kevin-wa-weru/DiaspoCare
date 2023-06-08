part of 'update_payout_threshold_cubit.dart';

@freezed
class UpdatePayoutThresholdState with _$UpdatePayoutThresholdState {
  const factory UpdatePayoutThresholdState.initial() = _Initial;
  const factory UpdatePayoutThresholdState.loading() = _Loading;
  const factory UpdatePayoutThresholdState.loaded(
    String amount,
  ) = _Loaded;
  const factory UpdatePayoutThresholdState.error(String message) = _Error;
}
