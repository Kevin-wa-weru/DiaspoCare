part of 'search_beneficiary_cubit.dart';

@freezed
class SearchBeneficiaryState with _$SearchBeneficiaryState {
  const factory SearchBeneficiaryState.initial() = _Initial;
  const factory SearchBeneficiaryState.loading() = _Loading;
  const factory SearchBeneficiaryState.loaded(
      Map<String, dynamic> beneficiaryDetails) = _Loaded;
  const factory SearchBeneficiaryState.error(String message) = _Error;
}
