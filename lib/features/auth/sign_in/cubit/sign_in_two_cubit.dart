import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_two_state.dart';
part 'sign_in_two_cubit.freezed.dart';

class SignInTwoCubit extends Cubit<SignInTwoState> {
  SignInTwoCubit() : super(const SignInTwoState.initial());

  signIn(String email, String password) async {
    emit(const SignInTwoState.loading());
    var response = await DiaspoCareAPis.login(email, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTimeUser', false);
    String? token = prefs.getString('userToken');

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    DiaspoCareAPis.registerFCM(fcmToken, token);

    emit(SignInTwoState.loaded(response));
  }
}
