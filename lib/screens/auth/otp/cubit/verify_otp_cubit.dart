import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_state.dart';
part 'verify_otp_cubit.freezed.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(const VerifyOtpState.initial());

  verifyOtp(otpCode, token) async {
    emit(const VerifyOtpState.loading());
    var response = await DiaspoCareAPis.verifyOtp(otpCode, token);
    emit(VerifyOtpState.loaded(response));
  }
}
