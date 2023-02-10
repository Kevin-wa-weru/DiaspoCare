import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_discount_state.dart';
part 'add_discount_cubit.freezed.dart';

class AddDiscountCubit extends Cubit<AddDiscountState> {
  AddDiscountCubit() : super(const AddDiscountState.initial());

  addDiscount(String discountName, int percentage) async {
    emit(const AddDiscountState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');

    var result =
        await DiaspoCareAPis.addDiscount(discountName, percentage, token);

    emit(AddDiscountState.loaded(result));
  }
}
