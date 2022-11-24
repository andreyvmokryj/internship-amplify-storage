part of 'search_transactions_bloc.dart';

abstract class SearchTransactionsState extends Equatable{
  @override
  List<Object> get props => [];
}

class SearchTransactionsInitial extends SearchTransactionsState{}

class SearchTransactionsLoading extends SearchTransactionsState{}

class SearchTransactionsLoaded extends SearchTransactionsState{
  final List<AppTransaction> transactions;

  SearchTransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [...transactions];
}