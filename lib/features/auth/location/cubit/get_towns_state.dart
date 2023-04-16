part of 'get_towns_cubit.dart';

@freezed
class GetTownsState with _$GetTownsState {
  const factory GetTownsState.initial() = _Initial;
  const factory GetTownsState.loading() = _Loading;
  const factory GetTownsState.loaded(List townNames) = _Loaded;
  const factory GetTownsState.error(String message) = _Error;
}
