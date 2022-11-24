part of 'search_transactions_bloc.dart';

abstract class SearchTransactionsEvent extends Equatable{
  const SearchTransactionsEvent();
}

class SearchTransactionsInitialize extends SearchTransactionsEvent{
  @override
  List<Object> get props => [];
}

class SearchTransactionsByFilters extends SearchTransactionsEvent{
  final List<String>? accounts;
  final List<String>? categories;
  final double? minAmount;
  final double? maxAmount;

  SearchTransactionsByFilters({this.accounts, this.categories, this.minAmount, this.maxAmount});

  @override
  List<Object> get props => [...?accounts, ...?categories, minAmount ?? '', maxAmount ?? ''];
}

class SearchTransactionsDisplayRequested extends SearchTransactionsEvent{
  final List<AppTransaction> transactions;

  SearchTransactionsDisplayRequested({required this.transactions});

  @override
  List<Object> get props => [...transactions];
}