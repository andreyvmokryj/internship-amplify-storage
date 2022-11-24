part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsPageModeChanged extends StatsEvent {
  final StatsPageMode statsPageMode;

  StatsPageModeChanged({required this.statsPageMode});

  @override
  List<Object> get props => [statsPageMode];
}