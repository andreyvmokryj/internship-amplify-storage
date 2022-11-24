part of 'budget_overview_bloc.dart';

abstract class BudgetOverviewState extends Equatable {
  const BudgetOverviewState();
}

class BudgetOverviewInitial extends BudgetOverviewState {
  @override
  List<Object> get props => [];
}

class BudgetOverviewLoading extends BudgetOverviewState {
  final String sliderCurrentTimeIntervalString;

  BudgetOverviewLoading({required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class BudgetOverviewLoaded extends BudgetOverviewState {
  final String sliderCurrentTimeIntervalString;
  final List<MonthlyCategoryExpense> monthlyCategoryExpenses;
  final MonthlyCategoryExpense summary;

  BudgetOverviewLoaded(
      {required this.sliderCurrentTimeIntervalString, required this.monthlyCategoryExpenses, required this.summary});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString, monthlyCategoryExpenses, summary];
}
