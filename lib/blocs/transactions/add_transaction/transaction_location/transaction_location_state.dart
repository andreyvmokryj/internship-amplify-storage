part of 'transaction_location_bloc.dart';

abstract class TransactionLocationState extends Equatable {
  const TransactionLocationState();
}

class TransactionLocationInitial extends TransactionLocationState {
  @override
  List<Object> get props => [];
}

class TransactionLocationCurrentLoading extends TransactionLocationState {
  @override
  List<Object> get props => [];
}

class TransactionLocationFromMapLoading extends TransactionLocationState {
  @override
  List<Object> get props => [];
}

class TransactionLocationSelected extends TransactionLocationState {
  final ExpenseLocation? expenseLocation;

  TransactionLocationSelected({required this.expenseLocation});

  @override
  List<Object> get props => [expenseLocation ?? ""];
}
