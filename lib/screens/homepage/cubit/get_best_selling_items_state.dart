part of 'get_best_selling_items_cubit.dart';

@freezed
class GetBestSellingItemsState with _$GetBestSellingItemsState {
  const factory GetBestSellingItemsState.initial() = _Initial;
  const factory GetBestSellingItemsState.loading() = _Loading;
  const factory GetBestSellingItemsState.loaded(List bestSellingItems) =
      _Loaded;
  const factory GetBestSellingItemsState.error(String message) = _Error;
}
