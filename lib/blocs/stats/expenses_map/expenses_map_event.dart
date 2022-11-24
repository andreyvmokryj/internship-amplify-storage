part of 'expenses_map_bloc.dart';

abstract class ExpensesMapEvent extends Equatable {
  const ExpensesMapEvent();
}

class ExpensesMapInitialize extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}

class ExpensesMapSliderBackPressed extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}

class ExpensesMapSliderForwardPressed extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}

class ExpensesMapCurrentLocationPressed extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}

class ExpensesMapFetchRequested extends ExpensesMapEvent {
  final DateTime dateForFetch;

  ExpensesMapFetchRequested({required this.dateForFetch});

  @override
  List<Object> get props => [dateForFetch];
}

class ExpensesMapDisplayRequested extends ExpensesMapEvent {
  final String data;
  final List<AppTransaction> transactions;

  ExpensesMapDisplayRequested({required this.transactions, required this.data});

  @override
  List<Object> get props => [data, transactions];
}

class ExpensesMapOnCameraMoved extends ExpensesMapEvent {

  final CameraPosition cameraPosition;

  ExpensesMapOnCameraMoved({required this.cameraPosition});

  @override
  List<Object> get props => [cameraPosition];
}

class ExpensesMapOnCameraMoveEnded extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}

class ExpensesMapMarkersUpdated extends ExpensesMapEvent {

  final Set<Marker> markers;

  ExpensesMapMarkersUpdated({required this.markers});

  @override
  List<Object> get props => [markers];
}

class ExpensesMapCreated extends ExpensesMapEvent {
  final GoogleMapController controller;

  ExpensesMapCreated({required this.controller});

  @override
  List<Object> get props => [controller];
}

class ExpensesMapLocaleChanged extends ExpensesMapEvent {

  @override
  List<Object> get props => [];
}

class ExpensesMapRefreshPressed extends ExpensesMapEvent {
  @override
  List<Object> get props => [];
}



