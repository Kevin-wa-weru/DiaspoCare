import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_basket_item_state.dart';
part 'add_basket_item_cubit.freezed.dart';

class AddBasketItemCubit extends Cubit<AddBasketItemState> {
  AddBasketItemCubit() : super(const AddBasketItemState.initial());

  addBasketItems(
    String basketId,
    String item,
    int percentageDiscount,
    int price,
    int quantity,
  ) async {
    emit(const AddBasketItemState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    var response = await DiaspoCareAPis.addBasketItem(
        basketId, item, percentageDiscount, price, quantity, 0, userToken!);

    emit(AddBasketItemState.loaded(response));
  }
}
