part of 'get_regions_cubit.dart';

@freezed
class GetRegionsState with _$GetRegionsState {
  const factory GetRegionsState.initial() = _Initial;
  const factory GetRegionsState.loading() = _Loading;
  const factory GetRegionsState.loaded(List regionNames) = _Loaded;
  const factory GetRegionsState.error(String message) = _Error;
}
