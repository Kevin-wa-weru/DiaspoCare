import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_basket_details_state.dart';
part 'get_basket_details_cubit.freezed.dart';

class GetBasketDetailsCubit extends Cubit<GetBasketDetailsState> {
  GetBasketDetailsCubit() : super(const GetBasketDetailsState.initial());

  getBasketDetails(basketID) async {
    emit(const GetBasketDetailsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.getBasketDetails(token!, basketID);
    emit(GetBasketDetailsState.loaded(response));
  }
}
