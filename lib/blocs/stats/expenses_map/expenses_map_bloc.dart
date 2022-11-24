import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/settings/styles/styles_bloc.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';
import 'package:radency_internship_project_2/utils/geolocator_utils.dart';
import 'package:radency_internship_project_2/utils/strings.dart';
import 'package:radency_internship_project_2/utils/styles.dart';
import 'package:radency_internship_project_2/utils/text_styles.dart';

part 'expenses_map_event.dart';

part 'expenses_map_state.dart';

class ExpensesMapBloc extends Bloc<ExpensesMapEvent, ExpensesMapState> {
  ExpensesMapBloc({
    required this.settingsBloc,
    required this.transactionsRepository,
    required this.stylesBloc,
  }) : super(ExpensesMapState());

  final TransactionsRepository transactionsRepository;
  final SettingsBloc settingsBloc;
  final StylesBloc stylesBloc;
  StreamSubscription? settingsSubscription;
  String locale = '';

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';
  StreamSubscription? expenseMapTimeIntervalSubscription;
  ClusterManager<AppTransaction>? _manager;

  @override
  Future<void> close() {
    expenseMapTimeIntervalSubscription?.cancel();
    settingsSubscription?.cancel();
    return super.close();
  }

  final CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 0,
  );

  @override
  Stream<ExpensesMapState> mapEventToState(
    ExpensesMapEvent event,
  ) async* {
    if (event is ExpensesMapInitialize) {
      yield* _mapExpensesMapInitializeToState();
    } else if (event is ExpensesMapCurrentLocationPressed) {
      yield* _mapExpensesMapCurrentLocationPressedToState();
    } else if (event is ExpensesMapSliderBackPressed) {
      yield* _mapExpensesMapSliderBackPressedToState();
    } else if (event is ExpensesMapSliderForwardPressed) {
      yield* _mapExpensesMapSliderForwardPressedToState();
    } else if (event is ExpensesMapFetchRequested) {
      yield* _mapTransactionsDailyFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is ExpensesMapDisplayRequested) {
      yield* _mapTransactionDailyDisplayRequestedToState(event.transactions);
    } else if (event is ExpensesMapOnCameraMoved) {
      _manager?.onCameraMove(event.cameraPosition);
    } else if (event is ExpensesMapOnCameraMoveEnded) {
      _manager?.updateMap();
    } else if (event is ExpensesMapCreated) {
      _manager?.setMapController(event.controller);
    } else if (event is ExpensesMapMarkersUpdated) {
      yield state.showMarkers(markers: event.markers);
    } else if (event is ExpensesMapLocaleChanged) {
      yield* _mapExpensesMapLocaleChangedToState();
    } else if (event is ExpensesMapRefreshPressed) {
      yield* _mapExpensesMapRefreshPressedToState();
    }
  }

  Stream<ExpensesMapState> _mapExpensesMapInitializeToState() async* {
    yield state.initial(cameraPosition: _defaultCameraPosition);

    _observedDate = DateTime.now();

    if (settingsBloc.state is LoadedSettingsState) {
      locale = settingsBloc.state.language;
    }
    settingsBloc.stream.listen((newSettingsState) {
      if (newSettingsState is LoadedSettingsState && newSettingsState.language != locale) {
        locale = newSettingsState.language;
        add(ExpensesMapLocaleChanged());
      }
    });

    _manager = ClusterManager<AppTransaction>(
      [ClusterItem(LatLng(37.42796133580664, -122.085749655962))],
      _updateMarkers,
      markerBuilder: _markerBuilder,
      initialZoom: 14.4746,
      levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0],
    );

    add(ExpensesMapFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<ExpensesMapState> _mapExpensesMapLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);

    yield state.setSliderTitle(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
  }

  Stream<ExpensesMapState> _mapTransactionsDailyFetchRequestedToState({required DateTime dateForFetch}) async* {
    expenseMapTimeIntervalSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield state.setSliderTitle(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, clearMarkers: true);
    expenseMapTimeIntervalSubscription =(await transactionsRepository
        .getTransactionsByTimePeriod(
            start: DateHelper().getFirstDayOfMonth(dateForFetch), end: DateHelper().getLastDayOfMonth(dateForFetch)))
        .listen((event) {
      add(ExpensesMapDisplayRequested(transactions: event.items, data: _sliderCurrentTimeIntervalString));
    });
  }

  Stream<ExpensesMapState> _mapTransactionDailyDisplayRequestedToState(List<AppTransaction> transactions) async* {
    List<ClusterItem<AppTransaction>> list = [];

    transactions.forEach((transaction) {
      if (transaction.transactionType == TransactionType.Expense) {
        if (transaction.locationLatitude != null && transaction.locationLongitude != null) {
          list.add(ClusterItem(LatLng(transaction.locationLatitude!, transaction.locationLongitude!), item: transaction));
        }
      }
    });

    _manager?.setItems(list);
  }

  Stream<ExpensesMapState> _mapExpensesMapCurrentLocationPressedToState() async* {
    yield state.setFocusing();

    try {
      Position position = await GeolocatorUtils().determinePosition();
      yield state.animateToPosition(latLng: LatLng(position.latitude, position.longitude));
    } catch (e) {
      yield state.showMessage(e.toString());
    }

    yield state.setFocused();
  }

  Stream<ExpensesMapState> _mapExpensesMapRefreshPressedToState() async* {
    add(ExpensesMapFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<ExpensesMapState> _mapExpensesMapSliderBackPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(ExpensesMapFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<ExpensesMapState> _mapExpensesMapSliderForwardPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(ExpensesMapFetchRequested(dateForFetch: _observedDate!));
  }

  Future<Marker> Function(Cluster<AppTransaction>) get _markerBuilder => (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(200,
              currency: getCurrencySymbol(settingsBloc.state.currency),
              value: _getExpensesClusterSum(cluster).toStringAsFixed(0)),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(double width, {required String currency, required String value}) async {
    double height = width * 0.78;

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = HexColor(stylesBloc.state.themeColors.accentColor);

    //Marker rectangle (background)

    RRect rrect = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(width / 2, height / 2 - height * 0.08), width: width, height: height - height * 0.16),
        Radius.circular(width * 0.16));

    canvas.drawRRect(
      rrect,
      paint1,
    );

    final path = Path()
      ..moveTo(width / 3, height - height * 0.17)
      ..lineTo(width / 2, height)
      ..lineTo(width / 3 * 2, height - height * 0.17);
    canvas.drawPath(path, paint1);

    // Expense amount text
    if (value != null) {
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

      // Text font and style
      textPainter.text = TextSpan(
          text: currency,
          style: textStyleTransactionListCurrency(size: height / 3, color: Colors.white),
          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(fontSize: height / 3, color: Colors.white, fontWeight: FontWeight.normal)),
            )
          ]);
      textPainter.layout();

      // Text position relative to background (here - centered)
      textPainter.paint(
        canvas,
        Offset(width / 2 - textPainter.width / 2, (height / 2 - height * 0.08) - textPainter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  _updateMarkers(Set<Marker> markers) {
    add(ExpensesMapMarkersUpdated(markers: markers));
  }

  double _getExpensesClusterSum(Cluster<AppTransaction> cluster) {
    double sum = 0;

    cluster.items.forEach((element) {
      if (element != null && element.transactionType == TransactionType.Expense) sum += element.amount;
    });

    return sum;
  }
}
