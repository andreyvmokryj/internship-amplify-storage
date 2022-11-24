part of 'add_transaction_bloc.dart';

abstract class AddTransactionState extends Equatable {
  const AddTransactionState();

  @override
  List<Object> get props => [];
}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoaded extends AddTransactionState {
  final List<String> expenseCategories;
  final List<String> incomeCategories;
  final List<String> accounts;


  AddTransactionLoaded({required this.incomeCategories, required this.expenseCategories, required this.accounts});

  @override
  List<Object> get props => [incomeCategories, expenseCategories, accounts];
}

class AddTransactionSuccessfulAndCompleted extends AddTransactionState {}

class AddTransactionSuccessfulAndContinued extends AddTransactionState {}
