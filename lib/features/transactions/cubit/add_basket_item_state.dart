part of 'add_basket_item_cubit.dart';

@freezed
class AddBasketItemState with _$AddBasketItemState {
  const factory AddBasketItemState.initial() = _Initial;
  const factory AddBasketItemState.loading() = _Loading;
  const factory AddBasketItemState.loaded(String message) = _Loaded;
  const factory AddBasketItemState.error(String message) = _Error;
}
