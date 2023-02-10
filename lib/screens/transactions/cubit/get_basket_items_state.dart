part of 'get_basket_items_cubit.dart';

@freezed
class GetBasketItemsState with _$GetBasketItemsState {
  const factory GetBasketItemsState.initial() = _Initial;
  const factory GetBasketItemsState.loading() = _Loading;
  const factory GetBasketItemsState.loaded(List basketItems) = _Loaded;
  const factory GetBasketItemsState.error(String message) = _Error;
}
