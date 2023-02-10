part of 'get_discounts_cubit.dart';

@freezed
class GetDiscountsState with _$GetDiscountsState {
  const factory GetDiscountsState.initial() = _Initial;
  const factory GetDiscountsState.loading() = _Loading;
  const factory GetDiscountsState.loaded(List discounts) = _Loaded;
  const factory GetDiscountsState.error(String message) = _Error;
}
