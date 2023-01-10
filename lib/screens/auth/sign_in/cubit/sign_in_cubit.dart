import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState.initial());

  signIn(String email, String password) async {
    emit(const SignInState.loading());
    var response = await DiaspoCareAPis.login(email, password);
    emit(SignInState.loaded(response));
  }
}
