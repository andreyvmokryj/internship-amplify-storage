part of 'transactions_calendar_bloc.dart';

abstract class TransactionsCalendarEvent extends Equatable {
  const TransactionsCalendarEvent();
}

class TransactionsCalendarInitialize extends TransactionsCalendarEvent {
  @override
  List<Object> get props => [];
}

class TransactionsCalendarGetPreviousMonthPressed extends TransactionsCalendarEvent {
  @override
  List<Object> get props => [];
}

class TransactionsCalendarGetNextMonthPressed extends TransactionsCalendarEvent {
  @override
  List<Object> get props => [];
}

class TransactionsCalendarFetchRequested extends TransactionsCalendarEvent {
  final DateTime dateForFetch;

  TransactionsCalendarFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class TransactionsCalendarDisplayRequested extends TransactionsCalendarEvent {
  final String sliderCurrentTimeIntervalString;
  final List<CalendarDay> daysData;
  final double expensesSummary;
  final double incomeSummary;

  TransactionsCalendarDisplayRequested({
    required this.daysData,
    required this.sliderCurrentTimeIntervalString,
    required this.incomeSummary,
    required this.expensesSummary,
  });

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class TransactionsCalendarLocaleChanged extends TransactionsCalendarEvent {
  @override
  List<Object> get props => [];
}

class TransactionsCalendarUserChanged extends TransactionsCalendarEvent {

  final String id;

  TransactionsCalendarUserChanged({required this.id});

  @override
  List<Object> get props => [id];
}

