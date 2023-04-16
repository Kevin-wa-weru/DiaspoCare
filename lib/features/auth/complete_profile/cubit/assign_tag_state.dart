part of 'assign_tag_cubit.dart';

@freezed
class AssignTagState with _$AssignTagState {
  const factory AssignTagState.initial() = _Initial;
  const factory AssignTagState.loading() = _Loading;
  const factory AssignTagState.loaded(String result) = _Loaded;
  const factory AssignTagState.error(String message) = _Error;
}
