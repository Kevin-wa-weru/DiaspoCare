part of 'get_bank_details_cubit.dart';

@freezed
class GetBankDetailsState with _$GetBankDetailsState {
  const factory GetBankDetailsState.initial() = _Initial;
  const factory GetBankDetailsState.loading() = _Loading;
  const factory GetBankDetailsState.loaded(Map<String, dynamic> bankdetails) =
      _Loaded;
  const factory GetBankDetailsState.error(String message) = _Error;
}
