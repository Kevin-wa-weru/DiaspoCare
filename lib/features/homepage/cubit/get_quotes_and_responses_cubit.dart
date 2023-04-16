import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';

part 'get_quotes_and_responses_state.dart';
part 'get_quotes_and_responses_cubit.freezed.dart';

class GetQuotesAndResponsesCubit extends Cubit<GetQuotesAndResponsesState> {
  GetQuotesAndResponsesCubit()
      : super(const GetQuotesAndResponsesState.initial());

  getQuotesAndResponse() async {
    emit(const GetQuotesAndResponsesState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List tempHolder = [];
    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.getVendorQuoteRequests(token!);

    for (var item in response) {
      var response = DiaspoCareAPis.getBasketDetails(token, item['name']);
      tempHolder.add(response);
    }

    emit(GetQuotesAndResponsesState.loaded(tempHolder));

    return tempHolder;
  }
}
