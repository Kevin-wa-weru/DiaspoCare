part of 'get_phone_n_umber_cubit.dart';

@freezed
class GetPhoneNUmberState with _$GetPhoneNUmberState {
  const factory GetPhoneNUmberState.initial() = _Initial;
  const factory GetPhoneNUmberState.loading() = _Loading;
  const factory GetPhoneNUmberState.loaded(String result) = _Loaded;
  const factory GetPhoneNUmberState.error(String message) = _Error;
}
