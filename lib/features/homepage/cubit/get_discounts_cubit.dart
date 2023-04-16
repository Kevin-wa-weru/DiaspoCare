import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_discounts_state.dart';
part 'get_discounts_cubit.freezed.dart';

class GetDiscountsCubit extends Cubit<GetDiscountsState> {
  GetDiscountsCubit() : super(const GetDiscountsState.initial());

  getDiscounts() async {
    emit(const GetDiscountsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var response = await DiaspoCareAPis.getDiscounts(token);

    emit(GetDiscountsState.loaded(response));
    return response;
  }
}
