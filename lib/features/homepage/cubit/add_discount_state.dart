part of 'add_discount_cubit.dart';

@freezed
class AddDiscountState with _$AddDiscountState {
  const factory AddDiscountState.initial() = _Initial;
  const factory AddDiscountState.loading() = _Loading;
  const factory AddDiscountState.loaded(String message) = _Loaded;
  const factory AddDiscountState.error(String message) = _Error;
}
