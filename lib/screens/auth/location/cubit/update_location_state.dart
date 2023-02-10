part of 'update_location_cubit.dart';

@freezed
class UpdateLocationState with _$UpdateLocationState {
  const factory UpdateLocationState.initial() = _Initial;
  const factory UpdateLocationState.loading() = _Loading;
  const factory UpdateLocationState.loaded(String message) = _Loaded;
  const factory UpdateLocationState.error(String message) = _Error;
}
