import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_accout_details_state.dart';
part 'get_accout_details_cubit.freezed.dart';

class GetAccoutDetailsCubit extends Cubit<GetAccoutDetailsState> {
  GetAccoutDetailsCubit() : super(const GetAccoutDetailsState.initial());

  getAccountDetails() async {
    emit(const GetAccoutDetailsState.loading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('userEmail');
    String? token = prefs.getString('userToken');

    var response =
        await DiaspoCareAPis.getAccountDetails(email!.trim(), token!);
    print('Helo from getting Account cubit $response');
    emit(GetAccoutDetailsState.loaded(response));
  }
}
