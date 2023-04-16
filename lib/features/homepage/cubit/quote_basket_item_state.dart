part of 'quote_basket_item_cubit.dart';

@freezed
class QuoteBasketItemState with _$QuoteBasketItemState {
  const factory QuoteBasketItemState.initial() = _Initial;
  const factory QuoteBasketItemState.loading() = _Loading;
  const factory QuoteBasketItemState.loaded(Map<String, dynamic> response) =
      _Loaded;
  const factory QuoteBasketItemState.error(String message) = _Error;
}
