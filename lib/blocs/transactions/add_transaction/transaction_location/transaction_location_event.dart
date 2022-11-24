part of 'transaction_location_bloc.dart';

abstract class TransactionLocationEvent extends Equatable {
  const TransactionLocationEvent();
}

class TransactionLocationMenuOpened extends TransactionLocationEvent {
  @override
  List<Object> get props => [];
}

class TransactionLocationCurrentPressed extends TransactionLocationEvent {
  final String languageCode;

  TransactionLocationCurrentPressed({required this.languageCode});

  @override
  List<Object> get props => [];
}

class TransactionLocationFromMapPressed extends TransactionLocationEvent {
  final String languageCode;
  final LatLng latLng;

  TransactionLocationFromMapPressed({required this.languageCode, required this.latLng});

  List<Object> get props => [languageCode];
}

class TransactionLocationCancelSelected extends TransactionLocationEvent {
  List<Object> get props => [];
}
