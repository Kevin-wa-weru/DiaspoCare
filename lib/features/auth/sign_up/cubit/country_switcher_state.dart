part of 'country_switcher_cubit.dart';

@freezed
class CountrySwitcherState with _$CountrySwitcherState {
  const factory CountrySwitcherState.initial() = _Initial;
  const factory CountrySwitcherState.loading() = _Loading;
  const factory CountrySwitcherState.loaded(String country, String code) =
      _Loaded;
  const factory CountrySwitcherState.error(String message) = _Error;
}
