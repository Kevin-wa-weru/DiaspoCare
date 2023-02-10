import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_basket_state.dart';
part 'add_basket_cubit.freezed.dart';

class AddBasketCubit extends Cubit<AddBasketState> {
  AddBasketCubit() : super(const AddBasketState.initial());

  addBasket(beneficiaryId) async {
    emit(const AddBasketState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    var response = await DiaspoCareAPis.addBasket(beneficiaryId, userToken!);

    emit(AddBasketState.loaded(response));
  }
}
