import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_basket_items_state.dart';
part 'get_basket_items_cubit.freezed.dart';

class GetBasketItemsCubit extends Cubit<GetBasketItemsState> {
  GetBasketItemsCubit() : super(const GetBasketItemsState.initial());

  getBasketItems(
    String basketId,
  ) async {
    emit(const GetBasketItemsState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    var response = await DiaspoCareAPis.getBasketItems(basketId, userToken!);

    var currency = await DiaspoCareAPis.getCountry();

    emit(GetBasketItemsState.loaded(response, currency));
  }
}
