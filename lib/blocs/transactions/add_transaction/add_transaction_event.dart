part of 'add_transaction_bloc.dart';

abstract class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object> get props => throw [];
}

class AddTransactionInitialize extends AddTransactionEvent {}

class AddTransaction extends AddTransactionEvent {
  final AppTransaction transaction;
  final bool isAddingCompleted;

  AddTransaction({required this.transaction, required this.isAddingCompleted});

  @override
  List<Object> get props => [transaction, isAddingCompleted];
}