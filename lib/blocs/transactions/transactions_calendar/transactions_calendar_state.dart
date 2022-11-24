part of 'transactions_calendar_bloc.dart';

abstract class TransactionsCalendarState extends Equatable {
  const TransactionsCalendarState();

  @override
  List<Object> get props => [];
}

class TransactionsCalendarInitial extends TransactionsCalendarState {}

class TransactionsCalendarLoading extends TransactionsCalendarState {
  final String sliderCurrentTimeIntervalString;

  TransactionsCalendarLoading({required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class TransactionsCalendarLoaded extends TransactionsCalendarState {
  final String sliderCurrentTimeIntervalString;
  final List<CalendarDay> daysData;
  final double expensesSummary;
  final double incomeSummary;

  TransactionsCalendarLoaded({
    required this.daysData,
    required this.sliderCurrentTimeIntervalString,
    required this.expensesSummary,
    required this.incomeSummary,
  });

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString, daysData];
}
