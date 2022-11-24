part of 'transaction_location_map_bloc.dart';

abstract class TransactionLocationMapEvent extends Equatable {
  const TransactionLocationMapEvent();
}

class TransactionLocationMapInitialize extends TransactionLocationMapEvent {
  @override
  List<Object> get props => [];
}

class TransactionLocationMapFocusPressed extends TransactionLocationMapEvent {
  @override
  List<Object> get props => [];
}
