import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_transaction_otp_state.dart';
part 'generate_transaction_otp_cubit.freezed.dart';

class GenerateTransactionOtpCubit extends Cubit<GenerateTransactionOtpState> {
  GenerateTransactionOtpCubit()
      : super(const GenerateTransactionOtpState.initial());

  generateOtp(String basketid) async {
    emit(const GenerateTransactionOtpState.loading());
    var response = await DiaspoCareAPis.generateTransactionOtp(basketid);
    emit(GenerateTransactionOtpState.loaded(response));
  }
}
