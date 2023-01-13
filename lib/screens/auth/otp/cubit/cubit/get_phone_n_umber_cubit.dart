import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_phone_n_umber_state.dart';
part 'get_phone_n_umber_cubit.freezed.dart';

class GetPhoneNUmberCubit extends Cubit<GetPhoneNUmberState> {
  GetPhoneNUmberCubit() : super(const GetPhoneNUmberState.initial());

  getPhone() async {
    emit(const GetPhoneNUmberState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('userPhoneNumber');

    String? countryCode = prefs.getString('persistentcountryCode');

    print('Phone Number from sharePrefference');
    print(phone);
    print(countryCode);

    if (countryCode == 'ke') {
      emit(GetPhoneNUmberState.loaded('+254$phone'));
    }

    if (countryCode == 'gh') {
      emit(GetPhoneNUmberState.loaded('+234$phone'));
    }

    if (countryCode == 'ng') {
      emit(GetPhoneNUmberState.loaded('+233$phone'));
    }
  }
}
