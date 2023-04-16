import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_towns_state.dart';
part 'get_towns_cubit.freezed.dart';

class GetTownsCubit extends Cubit<GetTownsState> {
  GetTownsCubit() : super(const GetTownsState.initial());

  getTowns(state) async {
    emit(const GetTownsState.loading());
    var response = await DiaspoCareAPis.getTown(state);
    emit(GetTownsState.loaded(response));
  }
}
