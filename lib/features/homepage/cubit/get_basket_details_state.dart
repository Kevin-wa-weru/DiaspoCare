part of 'get_basket_details_cubit.dart';

@freezed
class GetBasketDetailsState with _$GetBasketDetailsState {
  const factory GetBasketDetailsState.initial() = _Initial;
  const factory GetBasketDetailsState.loading() = _Loading;
  const factory GetBasketDetailsState.loaded(Map<String, dynamic> response) =
      _Loaded;
  const factory GetBasketDetailsState.error(String message) = _Error;
}
