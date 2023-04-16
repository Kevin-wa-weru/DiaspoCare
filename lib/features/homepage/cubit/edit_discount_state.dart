part of 'edit_discount_cubit.dart';

@freezed
class EditDiscountState with _$EditDiscountState {
  const factory EditDiscountState.initial() = _Initial;

  const factory EditDiscountState.loading() = _Loading;
  const factory EditDiscountState.loaded(String message) = _Loaded;
  const factory EditDiscountState.error(String message) = _Error;
}
