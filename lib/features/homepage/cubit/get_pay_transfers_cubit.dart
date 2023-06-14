import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_pay_transfers_state.dart';
part 'get_pay_transfers_cubit.freezed.dart';

class GetPayTransfersCubit extends Cubit<GetPayTransfersState> {
  GetPayTransfersCubit() : super(const GetPayTransfersState.initial());

  getTransfers() async {
    emit(const GetPayTransfersState.loading());
    List allTransfers = [];
    var response = await DiaspoCareAPis.getVendorTransfers('completed', 1);
    var response2 = await DiaspoCareAPis.getVendorTransfers('failed', 1);

    for (var i in response) {
      allTransfers.add(i);
    }

    for (var i in response2) {
      allTransfers.add(i);
    }

    emit(GetPayTransfersState.loaded(allTransfers));
  }
}
