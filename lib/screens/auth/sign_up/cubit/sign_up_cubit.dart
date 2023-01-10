import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.initial());

  signUp(String email, String countryCode, String phoneNumber,
      String password) async {
    emit(const SignUpState.loading());

    var response =
        await DiaspoCareAPis.signUp(email, countryCode, phoneNumber, password);
    emit(SignUpState.loaded(response));
  }
}
