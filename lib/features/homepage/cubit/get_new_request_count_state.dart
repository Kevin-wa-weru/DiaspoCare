part of 'get_new_request_count_cubit.dart';

@freezed
class GetNewRequestCountState with _$GetNewRequestCountState {
  const factory GetNewRequestCountState.initial() = _Initial;
  const factory GetNewRequestCountState.loading() = _Loading;
  const factory GetNewRequestCountState.loaded(String response) = _Loaded;
  const factory GetNewRequestCountState.error(String message) = _Error;
}
