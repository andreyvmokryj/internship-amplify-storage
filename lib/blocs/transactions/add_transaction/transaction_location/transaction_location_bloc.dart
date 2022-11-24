import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radency_internship_project_2/local_models/location.dart';
import 'package:radency_internship_project_2/utils/geolocator_utils.dart';

part 'transaction_location_event.dart';

part 'transaction_location_state.dart';

class TransactionLocationBloc extends Bloc<TransactionLocationEvent, TransactionLocationState> {
  TransactionLocationBloc() : super(TransactionLocationInitial());

  @override
  Stream<TransactionLocationState> mapEventToState(
    TransactionLocationEvent event,
  ) async* {
    if (event is TransactionLocationCurrentPressed) {
      yield* _mapTransactionLocationCurrentSelectedToState(languageCode: event.languageCode);
    } else if (event is TransactionLocationFromMapPressed) {
      yield* _mapTransactionLocationFromMapSelectedToState(languageCode: event.languageCode, latLng: event.latLng);
    } else if (event is TransactionLocationCancelSelected) {
      yield* _mapTransactionLocationCancelSelectedToState();
    } else if (event is TransactionLocationMenuOpened) yield TransactionLocationInitial();
  }

  Stream<TransactionLocationState> _mapTransactionLocationCurrentSelectedToState({required String languageCode}) async* {
    yield TransactionLocationCurrentLoading();

    try {
      Position position = await GeolocatorUtils().determinePosition();

      ExpenseLocation expenseLocation =
          await GeolocatorUtils().convertCoordinatesToExpenseLocation(latitude: position.latitude, longitude: position.longitude, languageCode: languageCode);

      yield TransactionLocationSelected(expenseLocation: expenseLocation);
    } catch (e) {
      // TODO: handle errors
      yield TransactionLocationSelected(expenseLocation: null);
    }
  }

  Stream<TransactionLocationState> _mapTransactionLocationFromMapSelectedToState({required String languageCode, LatLng? latLng}) async* {
    yield TransactionLocationFromMapLoading();

    if (latLng != null) {
      try {
        ExpenseLocation expenseLocation =
            await GeolocatorUtils().convertCoordinatesToExpenseLocation(latitude: latLng.latitude, longitude: latLng.longitude, languageCode: languageCode);
        yield TransactionLocationSelected(expenseLocation: expenseLocation);
      } catch (e) {
        // TODO: handle errors
        yield TransactionLocationSelected(expenseLocation: null);
      }
    } else {
      yield TransactionLocationSelected(expenseLocation: null);
    }
  }

  Stream<TransactionLocationState> _mapTransactionLocationCancelSelectedToState() async* {
    yield TransactionLocationSelected(expenseLocation: null);
  }
}
