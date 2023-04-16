import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_transaction_otp_state.dart';
part 'verify_transaction_otp_cubit.freezed.dart';

class VerifyTransactionOtpCubit extends Cubit<VerifyTransactionOtpState> {
  VerifyTransactionOtpCubit()
      : super(const VerifyTransactionOtpState.initial());

  verifyOtp(String basketid, otpCode) async {
    emit(const VerifyTransactionOtpState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response = await DiaspoCareAPis.verifyTransactionOtp(
        basketid, otpCode, userToken!);

    emit(VerifyTransactionOtpState.loaded(response));
  }
}
