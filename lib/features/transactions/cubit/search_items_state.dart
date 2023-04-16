part of 'search_items_cubit.dart';

@freezed
class SearchItemsState with _$SearchItemsState {
  const factory SearchItemsState.initial() = _Initial;
  const factory SearchItemsState.loading() = _Loading;
  const factory SearchItemsState.loaded(List items) = _Loaded;
  const factory SearchItemsState.error(String message) = _Error;
}
