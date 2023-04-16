import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'country_switcher_state.dart';
part 'country_switcher_cubit.freezed.dart';

class CountrySwitcherCubit extends Cubit<CountrySwitcherState> {
  CountrySwitcherCubit() : super(const CountrySwitcherState.initial());

  swithCountries(String country) async {
    emit(const CountrySwitcherState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (country == 'Kenya') {
      prefs.setString('countryCode', "ke");
      emit(const CountrySwitcherState.loaded('kenya', '+254'));
    }

    if (country == 'Nigeria') {
      prefs.setString('countryCode', "ng");
      emit(const CountrySwitcherState.loaded('nigeria', '+234'));
    }

    if (country == 'Ghana') {
      prefs.setString('countryCode', "gh");
      emit(const CountrySwitcherState.loaded('ghana', '+233'));
    }

    if (country == 'Uganda') {
      prefs.setString('countryCode', "ug");
      emit(const CountrySwitcherState.loaded('uganda', '+256'));
    }
  }
}
