part of 'transactions_monthly_bloc.dart';


abstract class TransactionsMonthlyEvent extends Equatable {
  const TransactionsMonthlyEvent();
}

class TransactionsMonthlyInitialize extends TransactionsMonthlyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsMonthlyGetPreviousYearPressed extends TransactionsMonthlyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsMonthlyGetNextYearPressed extends TransactionsMonthlyEvent {
  @override
  List<Object> get props => [];
}

class TransactionsMonthlyFetchRequested extends TransactionsMonthlyEvent {
  final DateTime dateForFetch;

  TransactionsMonthlyFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class TransactionMonthlyDisplayRequested extends TransactionsMonthlyEvent {
  final String sliderCurrentTimeIntervalString;
  final List<AppTransaction> yearTransactions;

  TransactionMonthlyDisplayRequested({required this.yearTransactions, required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [yearTransactions, sliderCurrentTimeIntervalString];
}

class TransactionMonthlyRefreshPressed extends TransactionsMonthlyEvent {
  @override
  List<Object> get props => [];
}