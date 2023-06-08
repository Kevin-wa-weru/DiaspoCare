import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_threshold_widget_state.dart';
part 'change_threshold_widget_cubit.freezed.dart';

class ChangeThresholdWidgetCubit extends Cubit<ChangeThresholdWidgetState> {
  ChangeThresholdWidgetCubit()
      : super(const ChangeThresholdWidgetState.initial());

  resolveInitialWidget(
    amount,
  ) async {
    emit(const ChangeThresholdWidgetState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? hasSetThreshold = prefs.getBool('hasSetThreshold');

    if (hasSetThreshold == false || hasSetThreshold == null) {
      emit(ChangeThresholdWidgetState.loaded(amount, 1));
    }

    if (hasSetThreshold == true) {
      emit(ChangeThresholdWidgetState.loaded(amount, 3));
    }
  }

  toogleWidget(amount, currentIndex) async {
    emit(const ChangeThresholdWidgetState.loading());

    if (currentIndex == 1) {
      emit(ChangeThresholdWidgetState.loaded(amount, 2));
    }

    if (currentIndex == 2) {
      emit(ChangeThresholdWidgetState.loaded(amount, 3));
    }

    if (currentIndex == 3) {
      emit(ChangeThresholdWidgetState.loaded(amount, 2));
    }
  }
}
