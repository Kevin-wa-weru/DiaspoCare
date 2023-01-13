import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_names_state.dart';
part 'bank_names_cubit.freezed.dart';

class BankNamesCubit extends Cubit<BankNamesState> {
  BankNamesCubit() : super(const BankNamesState.initial());

  getBankNames() async {
    emit(const BankNamesState.loading());
    var result = await DiaspoCareAPis.getBankNames();
    emit(BankNamesState.loaded(result));
  }
}
