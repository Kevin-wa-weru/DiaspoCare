import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_quote_requests_state.dart';
part 'get_quote_requests_cubit.freezed.dart';

class GetQuoteRequestsCubit extends Cubit<GetQuoteRequestsState> {
  GetQuoteRequestsCubit() : super(const GetQuoteRequestsState.initial());

  getQuotes() async {
    emit(const GetQuoteRequestsState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');

    List tempHolder = [];

    var response = await DiaspoCareAPis.getVendorQuoteRequests(token!);

    for (var item in response) {
      var response = await DiaspoCareAPis.getBasketDetails(token, item['name']);
      tempHolder.add(response);
    }

    List? requests = prefs.getStringList('localStorageRequest');

    emit(GetQuoteRequestsState.loaded(response, tempHolder, requests!));
    tempHolder = [];
  }
}
