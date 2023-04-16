part of 'get_dash_board_stats_cubit.dart';

@freezed
class GetDashBoardStatsState with _$GetDashBoardStatsState {
  const factory GetDashBoardStatsState.initial() = _Initial;
  const factory GetDashBoardStatsState.loading() = _Loading;
  const factory GetDashBoardStatsState.loaded(
      Map<String, dynamic> dashboardStats, String currency) = _Loaded;
  const factory GetDashBoardStatsState.error(
    String message,
  ) = _Error;
}
