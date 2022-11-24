import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';

part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(const StatsState());

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is StatsPageModeChanged) {
      yield* _mapStatsPageModeChangedToState(event.statsPageMode);
    }
  }

  Stream<StatsState> _mapStatsPageModeChangedToState(StatsPageMode statsPageMode) async* {
    switch (statsPageMode) {
      case StatsPageMode.chart:
        yield state.toChartMode();
        break;
      case StatsPageMode.budget:
        yield state.toBudgetMode();
        break;
      case StatsPageMode.map:
        yield state.toMapMode();
        break;
    }
  }
}
