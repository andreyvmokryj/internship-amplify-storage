part of 'transactions_daily_bloc.dart';

abstract class TransactionsDailyEvent extends Equatable {
  const TransactionsDailyEvent();
}

class TransactionsDailyInitialize extends TransactionsDailyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsDailyGetPreviousMonthPressed extends TransactionsDailyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsDailyGetNextMonthPressed extends TransactionsDailyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsDailyFetchRequested extends TransactionsDailyEvent {
  final DateTime dateForFetch;

  TransactionsDailyFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class TransactionsDailyDisplayRequested extends TransactionsDailyEvent {
  final String sliderCurrentTimeIntervalString;
  final List<AppTransaction> transactions;

  TransactionsDailyDisplayRequested({required this.transactions, required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [transactions, sliderCurrentTimeIntervalString];
}

class TransactionsDailyLocaleChanged extends TransactionsDailyEvent {
  @override
  List<Object> get props => [];
}

class TransactionDailyUserChanged extends TransactionsDailyEvent {
  final String id;

  TransactionDailyUserChanged({required this.id});

  @override
  List<Object> get props => [id];
}

class TransactionDailyDelete extends TransactionsDailyEvent {
  final String transactionId;

  TransactionDailyDelete({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
