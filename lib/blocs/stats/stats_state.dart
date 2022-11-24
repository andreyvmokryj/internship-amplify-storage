part of 'stats_bloc.dart';

enum StatsPageMode { chart, map, budget }

class StatsState extends Equatable {
  const StatsState({this.statsPageMode = StatsPageMode.chart});

  final StatsPageMode statsPageMode;

  @override
  List<Object> get props => [statsPageMode];

  StatsState copyWith({
    StatsPageMode? statsPageMode,
  }) {
    return StatsState(
      statsPageMode: statsPageMode ?? this.statsPageMode,
    );
  }

  StatsState toChartMode() {
    return copyWith(statsPageMode: StatsPageMode.chart);
  }

  StatsState toBudgetMode() {
    return copyWith(statsPageMode: StatsPageMode.budget);
  }

  StatsState toMapMode() {
    return copyWith(statsPageMode: StatsPageMode.map);
  }
}
