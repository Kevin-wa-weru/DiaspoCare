import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.initial());

  signUp(String email, String phoneNumber, String password) async {
    emit(const SignUpState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? countryCode = prefs.getString('countryCode');

    var response =
        await DiaspoCareAPis.signUp(email, countryCode, phoneNumber, password);

    if (response == 'Your Account has been created') {
      prefs.setString('userEmail', email);
      prefs.setString('userPhoneNumber', phoneNumber);
      prefs.setString('persistentcountryCode', countryCode!);
      prefs.setString('password', password);
      // prefs.setBool('isFirstTimeUser', true);
    } else {
      // prefs.setBool('isFirstTimeUser', false);
    }
    emit(SignUpState.loaded(response));
  }
}
