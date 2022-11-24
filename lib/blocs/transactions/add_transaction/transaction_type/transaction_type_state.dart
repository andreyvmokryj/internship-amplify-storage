part of 'transaction_type_bloc.dart';

class TransactionTypeState extends Equatable{
  final TransactionType selectedType;

  TransactionTypeState(this.selectedType);

  @override
  List<Object> get props => [selectedType];
}