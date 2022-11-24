part of 'expenses_chart_bloc.dart';

abstract class ExpensesChartState extends Equatable {
  const ExpensesChartState();

  @override
  List<Object> get props => [];
}

class ExpensesChartInitial extends ExpensesChartState {}

class ExpensesChartLoading extends ExpensesChartState {
  final String sliderCurrentTimeIntervalString;

  ExpensesChartLoading({required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class ExpensesChartLoaded extends ExpensesChartState {
  final String sliderCurrentTimeIntervalString;
  final List<ChartSection> chartCategories;
  final List<ChartCategoryDetails> allCategories;

  ExpensesChartLoaded({
    required this.chartCategories,
    required this.allCategories,
    required this.sliderCurrentTimeIntervalString,
  });

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString, chartCategories, allCategories];
}
