part of 'transactions_slider_bloc.dart';

abstract class TransactionsSliderState extends Equatable {
  const TransactionsSliderState();
}

class TransactionsSliderInitial extends TransactionsSliderState {
  @override
  List<Object> get props => [];
}

class TransactionsSliderLoading extends TransactionsSliderState {
  @override
  List<Object> get props => [];
}

class TransactionsSliderLoaded extends TransactionsSliderState {
  final TransactionsSliderMode transactionsSliderMode;

  TransactionsSliderLoaded({required this.transactionsSliderMode});

  @override
  List<Object> get props => [transactionsSliderMode];
}
