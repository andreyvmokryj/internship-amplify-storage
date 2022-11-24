part of 'transaction_type_bloc.dart';

abstract class TransactionTypeEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class TransactionSelectType extends TransactionTypeEvent{
  final TransactionType transactionType;

  TransactionSelectType(this.transactionType);

  @override
  List<Object> get props => [transactionType];
}