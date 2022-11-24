part of 'transactions_slider_bloc.dart';

abstract class TransactionsSliderEvent extends Equatable {
  const TransactionsSliderEvent();
}

class TransactionsSliderInitialize extends TransactionsSliderEvent {
  @override
  List<Object> get props => [];
}

class TransactionsSliderModeChanged extends TransactionsSliderEvent {
  final int index;

  TransactionsSliderModeChanged({required this.index});

  @override
  List<Object> get props => [index];
}
