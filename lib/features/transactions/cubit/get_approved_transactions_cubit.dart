import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_approved_transactions_state.dart';
part 'get_approved_transactions_cubit.freezed.dart';

class GetApprovedTransactionsCubit extends Cubit<GetApprovedTransactionsState> {
  GetApprovedTransactionsCubit()
      : super(const GetApprovedTransactionsState.initial());

  getApprovedTransaction() async {
    emit(const GetApprovedTransactionsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response =
        await DiaspoCareAPis.getVendorTransactions('approved', 1, userToken!);
    emit(GetApprovedTransactionsState.loaded(response));
  }
}
