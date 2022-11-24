part of 'transactions_daily_bloc.dart';

abstract class TransactionsDailyState extends Equatable {
  const TransactionsDailyState();

  @override
  List<Object> get props => [];
}

class TransactionsDailyInitial extends TransactionsDailyState {}

class TransactionsDailyLoading extends TransactionsDailyState {
  final String sliderCurrentTimeIntervalString;

  TransactionsDailyLoading({required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString];
}

class TransactionsDailyLoaded extends TransactionsDailyState {
  final String sliderCurrentTimeIntervalString;
  final Map<int, List<AppTransaction>> dailySortedTransactions;

  TransactionsDailyLoaded({required this.dailySortedTransactions, required this.sliderCurrentTimeIntervalString});

  @override
  List<Object> get props => [sliderCurrentTimeIntervalString, dailySortedTransactions];
}
