import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_items_state.dart';
part 'search_items_cubit.freezed.dart';

class SearchItemsCubit extends Cubit<SearchItemsState> {
  SearchItemsCubit() : super(const SearchItemsState.initial());

  searchItem(query) async {
    emit(const SearchItemsState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response = await DiaspoCareAPis.searchMasterList(query, userToken!);
    emit(SearchItemsState.loaded(response));
  }
}
