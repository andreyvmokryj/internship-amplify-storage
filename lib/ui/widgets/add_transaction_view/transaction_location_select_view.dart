import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/transaction_location_map/transaction_location_map_bloc.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';

class TransactionLocationSelectView extends StatefulWidget {
  @override
  _TransactionLocationSelectViewState createState() => _TransactionLocationSelectViewState();
}

class _TransactionLocationSelectViewState extends State<TransactionLocationSelectView> {
  CameraPosition? _cameraPosition;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(null);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.addTransactionLocationViewTitle),
        ),
        floatingActionButton: _fabs(),
        body: body(),
      ),
    );
  }

  Widget body() {
    return BlocConsumer<TransactionLocationMapBloc, TransactionLocationMapState>(listener: (context, state) {
      if (state.shouldAnimateToPosition) {
        _animateCamera(state.animateTargetPosition!);
      }

      if (state.message != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
      }
    }, builder: (context, state) {
      if (state.isInitialized) {
        return Stack(
          children: [
            GoogleMap(
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                  _cameraPosition = state.initialCameraPosition;
                },
                onCameraMove: (cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                zoomControlsEnabled: false,
                initialCameraPosition: state.initialCameraPosition!),
            Align(
              alignment: Alignment.center,
              child: new Icon(Icons.person_pin_circle, size: 50.0),
            )
          ],
        );
      }

      return SizedBox();
    });
  }

  Widget _fabs() {
    return BlocBuilder<TransactionLocationMapBloc, TransactionLocationMapState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            state.isFocusing
                ? FloatingActionButton(
                    onPressed: null,
                    backgroundColor: Theme.of(context).disabledColor,
                    child: CircularProgressIndicator(),
                  )
                : FloatingActionButton(
                    onPressed: () {
                      context.read<TransactionLocationMapBloc>().add(TransactionLocationMapFocusPressed());
                    },
                    child: Icon(Icons.my_location),
                  ),
            SizedBox(
              height: 15,
            ),
            FloatingActionButton.extended(
              label: Text(S.current.addTransactionLocationViewSelectButton),
              onPressed: () {
                Navigator.of(context).pop(_cameraPosition?.target);
              },
              icon: Icon(Icons.add_location),
            ),
          ],
        );
      },
    );
  }

  Future<void> _animateCamera(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 17)));
  }
}
