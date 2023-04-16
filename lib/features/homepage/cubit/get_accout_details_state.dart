part of 'get_accout_details_cubit.dart';

@freezed
class GetAccoutDetailsState with _$GetAccoutDetailsState {
  const factory GetAccoutDetailsState.initial() = _Initial;
  const factory GetAccoutDetailsState.loading() = _Loading;
  const factory GetAccoutDetailsState.loaded(
      Map<String, dynamic> accountDetails) = _Loaded;
  const factory GetAccoutDetailsState.error(String message) = _Error;
}
