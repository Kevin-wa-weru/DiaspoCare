import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initialise_transaction_state.dart';
part 'initialise_transaction_cubit.freezed.dart';

class InitialiseTransactionCubit extends Cubit<InitialiseTransactionState> {
  InitialiseTransactionCubit()
      : super(const InitialiseTransactionState.initial());

  initialiseTransaction(String basketid, String secureCode) async {
    emit(const InitialiseTransactionState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response = await DiaspoCareAPis.initialiseTransaction(
        basketid, secureCode, userToken!);

    emit(InitialiseTransactionState.loaded(response));
  }
}
