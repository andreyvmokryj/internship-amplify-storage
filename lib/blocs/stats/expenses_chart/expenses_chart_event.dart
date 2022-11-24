part of 'expenses_chart_bloc.dart';

abstract class ExpensesChartEvent extends Equatable {
  const ExpensesChartEvent();
}

class ExpensesChartInitialize extends ExpensesChartEvent {
  @override
  List<Object> get props => [];
}

class ExpensesChartGetPreviousMonthPressed extends ExpensesChartEvent {
  @override
  List<Object> get props => [];
}

class ExpensesChartGetNextMonthPressed extends ExpensesChartEvent {
  @override
  List<Object> get props => [];
}

class ExpensesChartFetchRequested extends ExpensesChartEvent {
  final DateTime dateForFetch;

  ExpensesChartFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class ExpensesChartDisplayRequested extends ExpensesChartEvent {
  final String sliderCurrentTimeIntervalString;
  final List<AppTransaction> transactions;

  ExpensesChartDisplayRequested({required this.transactions, required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [transactions, sliderCurrentTimeIntervalString];
}

class ExpensesChartLocaleChanged extends ExpensesChartEvent {
  @override
  List<Object> get props => [];
}

class ExpensesChartUserChanged extends ExpensesChartEvent {
  final String id;

  ExpensesChartUserChanged({required this.id});

  @override
  List<Object> get props => [id];
}

class ExpensesChartRefreshPressed extends ExpensesChartEvent {
  @override
  List<Object> get props => [];
}
