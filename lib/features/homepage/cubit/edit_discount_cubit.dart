import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_discount_state.dart';
part 'edit_discount_cubit.freezed.dart';

class EditDiscountCubit extends Cubit<EditDiscountState> {
  EditDiscountCubit() : super(const EditDiscountState.initial());

  editDiscount(String discountName, int percentage, String discountId) async {
    emit(const EditDiscountState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    var result = await DiaspoCareAPis.editDiscount(
        discountName, percentage, discountId, token!);

    emit(EditDiscountState.loaded(result));
  }
}
