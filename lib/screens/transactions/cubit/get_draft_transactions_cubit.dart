import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_draft_transactions_state.dart';
part 'get_draft_transactions_cubit.freezed.dart';

class GetDraftTransactionsCubit extends Cubit<GetDraftTransactionsState> {
  GetDraftTransactionsCubit()
      : super(const GetDraftTransactionsState.initial());

  getDraftTransaction() async {
    emit(const GetDraftTransactionsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response =
        await DiaspoCareAPis.getVendorTransactions('draft', 1, userToken!);
    print('Draft transactions $response');
    emit(GetDraftTransactionsState.loaded(response));
  }
}
