import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'respond_to_quote_state.dart';
part 'respond_to_quote_cubit.freezed.dart';

class RespondToQuoteCubit extends Cubit<RespondToQuoteState> {
  RespondToQuoteCubit() : super(RespondToQuoteState.initial(getLocalRequest()));

  respondToQuote(requestID) async {
    emit(const RespondToQuoteState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.respondToQuote(token!, requestID);
    emit(RespondToQuoteState.loaded(response, requestID));
  }
}

getLocalRequest() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List? newRequests = prefs.getStringList('persistentLocalRequests');
  return newRequests;
}
