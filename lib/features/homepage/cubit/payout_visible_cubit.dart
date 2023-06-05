import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'payout_visible_state.dart';
part 'payout_visible_cubit.freezed.dart';

class PayoutVisibleCubit extends Cubit<PayoutVisibleState> {
  PayoutVisibleCubit() : super(const PayoutVisibleState.initial());

  changeVisibility(bool isVisible) async {
    print('FSJNjfnsjfbjsf $isVisible');
    emit(const PayoutVisibleState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('payoutVisible', isVisible);
    bool? visiblity = prefs.getBool('payoutVisible');

    emit(PayoutVisibleState.loaded(visiblity!));
  }
}
