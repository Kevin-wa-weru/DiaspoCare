part of 'change_threshold_widget_cubit.dart';

@freezed
class ChangeThresholdWidgetState with _$ChangeThresholdWidgetState {
  const factory ChangeThresholdWidgetState.initial() = _Initial;
  const factory ChangeThresholdWidgetState.loading() = _Loading;
  const factory ChangeThresholdWidgetState.loaded(amount, index) = _Loaded;
  const factory ChangeThresholdWidgetState.error(String message) = _Error;
}
