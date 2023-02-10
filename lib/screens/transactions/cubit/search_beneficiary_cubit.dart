import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_beneficiary_state.dart';
part 'search_beneficiary_cubit.freezed.dart';

class SearchBeneficiaryCubit extends Cubit<SearchBeneficiaryState> {
  SearchBeneficiaryCubit() : super(const SearchBeneficiaryState.initial());

  searchBeneficiary(String beneficiarName) async {
    emit(const SearchBeneficiaryState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    var response =
        await DiaspoCareAPis.searchBeneficiary(beneficiarName, userToken!);
    emit(SearchBeneficiaryState.loaded(response));
  }
}
