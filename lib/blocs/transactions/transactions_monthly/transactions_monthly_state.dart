part of 'transactions_monthly_bloc.dart';

abstract class TransactionsMonthlyState extends Equatable {
  const TransactionsMonthlyState();

  @override
  List<Object> get props => [];
}

class TransactionsMonthlyInitial extends TransactionsMonthlyState {}

class TransactionsMonthlyLoading extends TransactionsMonthlyState {
  final String sliderCurrentTimeIntervalString;

  TransactionsMonthlyLoading({required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class TransactionsMonthlyLoaded extends TransactionsMonthlyState {
  final String sliderCurrentTimeIntervalString;
  final List<MonthDetails> yearSummary;

  TransactionsMonthlyLoaded({required this.yearSummary, required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [yearSummary, sliderCurrentTimeIntervalString];
}
