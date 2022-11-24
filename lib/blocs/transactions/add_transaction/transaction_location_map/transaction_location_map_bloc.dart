import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radency_internship_project_2/utils/geolocator_utils.dart';

part 'transaction_location_map_event.dart';

part 'transaction_location_map_state.dart';

class TransactionLocationMapBloc extends Bloc<TransactionLocationMapEvent, TransactionLocationMapState> {
  TransactionLocationMapBloc() : super(TransactionLocationMapState());

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 0,
  );

  @override
  Stream<TransactionLocationMapState> mapEventToState(
    TransactionLocationMapEvent event,
  ) async* {
    if (event is TransactionLocationMapInitialize) {
      yield* _mapTransactionLocationMapInitializeToState();
    } else if (event is TransactionLocationMapFocusPressed) {
      yield* _mapTransactionLocationMapFocusPressedToState();
    }
  }

  Stream<TransactionLocationMapState> _mapTransactionLocationMapInitializeToState() async* {
    // TODO: add fetching of last saved location from local storage

    yield state.initial(cameraPosition: _kGooglePlex);

    add(TransactionLocationMapFocusPressed());
  }

  Stream<TransactionLocationMapState> _mapTransactionLocationMapFocusPressedToState() async* {
    yield state.setFocusing();

    try {
      Position position = await GeolocatorUtils().determinePosition();
      yield state.animateToPosition(latLng: LatLng(position.latitude, position.longitude));
    } catch (e) {
      yield state.showMessage(e.toString());
    }

    yield state.setFocused();
  }
}
