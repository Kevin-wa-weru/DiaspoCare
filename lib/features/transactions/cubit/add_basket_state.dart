part of 'add_basket_cubit.dart';

@freezed
class AddBasketState with _$AddBasketState {
  const factory AddBasketState.initial() = _Initial;
  const factory AddBasketState.loading() = _Loading;
  const factory AddBasketState.loaded(Map<String, dynamic> basketDetails) =
      _Loaded;
  const factory AddBasketState.error(String message) = _Error;
}
