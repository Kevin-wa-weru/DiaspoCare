part of 'get_pay_transfers_cubit.dart';

@freezed
class GetPayTransfersState with _$GetPayTransfersState {
  const factory GetPayTransfersState.initial() = _Initial;
  const factory GetPayTransfersState.loading() = _Loading;
  const factory GetPayTransfersState.loaded(List transfers) = _Loaded;
  const factory GetPayTransfersState.error(String message) = _Error;
}
