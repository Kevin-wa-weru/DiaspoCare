import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_best_selling_items_state.dart';
part 'get_best_selling_items_cubit.freezed.dart';

class GetBestSellingItemsCubit extends Cubit<GetBestSellingItemsState> {
  GetBestSellingItemsCubit() : super(const GetBestSellingItemsState.initial());

  getBestSellingItems() async {
    emit(const GetBestSellingItemsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('userToken');
    String? facilityName = prefs.getString('facilityName');
    if (facilityName == null) {
    } else {
      var response =
          await DiaspoCareAPis.getBestSellingItems(token, facilityName);

      if (response.length > 4) {
        int startIndex = 0;
        int endIndex = 4;

        List subList = response.sublist(startIndex, endIndex);
        emit(GetBestSellingItemsState.loaded(subList));
      } else {
        emit(GetBestSellingItemsState.loaded(response));
      }

      return response;
    }
  }
}
