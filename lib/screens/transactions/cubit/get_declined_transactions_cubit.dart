import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_declined_transactions_state.dart';
part 'get_declined_transactions_cubit.freezed.dart';

class GetDeclinedTransactionsCubit extends Cubit<GetDeclinedTransactionsState> {
  GetDeclinedTransactionsCubit()
      : super(const GetDeclinedTransactionsState.initial());

  getDeclinedTransaction() async {
    emit(const GetDeclinedTransactionsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response =
        await DiaspoCareAPis.getVendorTransactions('declined', 1, userToken!);
    emit(GetDeclinedTransactionsState.loaded(response));
  }
}
