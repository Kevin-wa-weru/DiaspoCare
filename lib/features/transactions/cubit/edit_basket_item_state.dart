part of 'edit_basket_item_cubit.dart';

@freezed
class EditBasketItemState with _$EditBasketItemState {
  const factory EditBasketItemState.initial() = _Initial;
  const factory EditBasketItemState.loading() = _Loading;
  const factory EditBasketItemState.loaded(String message) = _Loaded;
  const factory EditBasketItemState.error(String message) = _Error;
}
