import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'quote_basket_item_state.dart';
part 'quote_basket_item_cubit.freezed.dart';

class QuoteBasketItemCubit extends Cubit<QuoteBasketItemState> {
  QuoteBasketItemCubit() : super(const QuoteBasketItemState.initial());

  quoteBasketItem(basketID, price, qty) async {
    emit(const QuoteBasketItemState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.createQuoteForBasketItem(
        token!, basketID, price, qty);
    emit(QuoteBasketItemState.loaded(response));
  }
}
