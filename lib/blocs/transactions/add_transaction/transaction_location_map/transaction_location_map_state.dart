part of 'transaction_location_map_bloc.dart';

class TransactionLocationMapState extends Equatable {
  TransactionLocationMapState({
    this.isInitialized = false,
    this.initialCameraPosition,
    this.isFocusing = false,
    this.shouldAnimateToPosition = false,
    this.animateTargetPosition,
    this.message,
  });

  final bool isInitialized;
  final CameraPosition? initialCameraPosition;
  final bool isFocusing;
  final bool shouldAnimateToPosition;
  final LatLng? animateTargetPosition;
  final String? message;

  @override
  List<Object> get props => [
        isInitialized,
        initialCameraPosition ?? "",
        isFocusing,
        shouldAnimateToPosition,
        animateTargetPosition ?? "",
        message ?? "",
      ];

  TransactionLocationMapState initial({required CameraPosition cameraPosition}) {
    return copyWith(initialCameraPosition: cameraPosition, isInitialized: true);
  }

  TransactionLocationMapState setFocusing() {
    return copyWith(isFocusing: true);
  }

  TransactionLocationMapState setFocused() {
    return copyWith(isFocusing: false);
  }

  TransactionLocationMapState animateToPosition({required LatLng latLng}) {
    return copyWith(animateTargetPosition: latLng, shouldAnimateToPosition: true);
  }

  TransactionLocationMapState showMessage(String message) {
    return copyWith(message: message);
  }

  TransactionLocationMapState copyWith({
    bool? isInitialized,
    CameraPosition? initialCameraPosition,
    bool? isFocusing,
    bool? shouldAnimateToPosition,
    LatLng? animateTargetPosition,
    String? message,
  }) {
    return TransactionLocationMapState(
        initialCameraPosition: initialCameraPosition ?? this.initialCameraPosition,
        isFocusing: isFocusing ?? this.isFocusing,
        isInitialized: isInitialized ?? this.isInitialized,
        shouldAnimateToPosition: shouldAnimateToPosition ?? false,
        animateTargetPosition: animateTargetPosition ?? null,
        message: message ?? null);
  }
}
