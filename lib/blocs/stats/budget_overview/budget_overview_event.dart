part of 'budget_overview_bloc.dart';

abstract class BudgetOverviewEvent extends Equatable {
  const BudgetOverviewEvent();
}

class BudgetOverviewInitialize extends BudgetOverviewEvent {
  @override
  List<Object> get props => [];
}

class BudgetOverviewGetPreviousMonthPressed extends BudgetOverviewEvent {
  @override
  List<Object> get props => [];
}

class BudgetOverviewGetNextMonthPressed extends BudgetOverviewEvent {
  @override
  List<Object> get props => [];
}

class BudgetOverviewFetchRequested extends BudgetOverviewEvent {
  final DateTime dateForFetch;

  BudgetOverviewFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class BudgetOverviewDisplayRequested extends BudgetOverviewEvent {

  BudgetOverviewDisplayRequested();

  @override
  List<Object> get props => [];
}

class BudgetOverviewCategoryBudgetSaved extends BudgetOverviewEvent {
  final CategoryBudget categoryBudget;

  BudgetOverviewCategoryBudgetSaved({required this.categoryBudget});

  @override
  List<Object> get props => [categoryBudget];
}

class BudgetOverviewLocaleChanged extends BudgetOverviewEvent {

  @override
  List<Object> get props => [];
}

class BudgetOverviewUserChanged extends BudgetOverviewEvent {

  final String userId;

  BudgetOverviewUserChanged({required this.userId});

  @override
  List<Object> get props => [userId];
}