import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_basket_item_state.dart';
part 'edit_basket_item_cubit.freezed.dart';

class EditBasketItemCubit extends Cubit<EditBasketItemState> {
  EditBasketItemCubit() : super(const EditBasketItemState.initial());

  editBasketItem(
      String basketItemId, String itemName, int price, int quantity) async {
    emit(const EditBasketItemState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    var response = await DiaspoCareAPis.editBasketItems(
        userToken!, basketItemId, itemName, price, quantity);

    emit(EditBasketItemState.loaded(response));
  }
}
