import 'dart:async';
import 'dart:collection';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/providers/amplify_api_provider.dart';
import 'package:radency_internship_project_2/providers/amplify_auth_service.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'transactions_daily_event.dart';

part 'transactions_daily_state.dart';

class TransactionsDailyBloc extends Bloc<TransactionsDailyEvent, TransactionsDailyState> {
  TransactionsDailyBloc({
    required this.settingsBloc,
    required this.transactionsRepository,
    required this.apiProvider,
    required this.amplifyAuthenticationService,
  }) : super(TransactionsDailyInitial());

  final TransactionsRepository transactionsRepository;
  final AmplifyApiProvider apiProvider;
  final AmplifyAuthenticationService amplifyAuthenticationService;

  SettingsBloc settingsBloc;
  StreamSubscription? settingsSubscription;
  String locale = '';

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';

  List<AppTransaction> dailyData = [];

  StreamSubscription? dailyTransactionsSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;
  StreamSubscription<AmplifyApiEvent>? _onTransactionEventSubscription;

  @override
  Future<void> close() {
    dailyTransactionsSubscription?.cancel();
    settingsSubscription?.cancel();
    _onTransactionEventSubscription?.cancel();
    _onUserChangedSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TransactionsDailyState> mapEventToState(
    TransactionsDailyEvent event,
  ) async* {
    if (event is TransactionsDailyInitialize) {
      yield* _mapTransactionsDailyInitializeToState();
    } else if (event is TransactionsDailyGetPreviousMonthPressed) {
      yield* _mapTransactionsDailyGetPreviousMonthPressedToState();
    } else if (event is TransactionsDailyGetNextMonthPressed) {
      yield* _mapTransactionsDailyGetNextMonthPressedToState();
    } else if (event is TransactionsDailyFetchRequested) {
      yield* _mapTransactionsDailyFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is TransactionsDailyDisplayRequested) {
      yield* _mapTransactionDailyDisplayRequestedToState(event.transactions);
    } else if (event is TransactionsDailyLocaleChanged) {
      yield* _mapTransactionsDailyLocaleChangedToState();
    } else if (event is TransactionDailyUserChanged) {
      yield* _mapTransactionDailyUserChangedToState(event.id);
    } else if (event is TransactionDailyDelete) {
      yield* _mapTransactionDailyDeleteToState(event.transactionId);
    }
  }

  Stream<TransactionsDailyState> _mapTransactionsDailyInitializeToState() async* {
    _observedDate = DateTime.now();

    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      _onTransactionEventSubscription?.cancel();

      print("${hubEvent.payload?.userId}");
        if (hubEvent.payload == null) {
          dailyData.clear();
          add(TransactionsDailyDisplayRequested(
              sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: dailyData));
        } else {
          add(TransactionDailyUserChanged(id: hubEvent.payload!.userId));
        }
    });

    if (settingsBloc.state is LoadedSettingsState) {
      locale = settingsBloc.state.language;
    }
    settingsBloc.stream.listen((newSettingsState) {
      print("TransactionsDailyBloc._mapTransactionsDailyInitializeToState: newSettingsState");
      if (newSettingsState is LoadedSettingsState && newSettingsState.language != locale) {
        locale = newSettingsState.language;
        add(TransactionsDailyLocaleChanged());
      }
    });

    add(TransactionDailyUserChanged(id: (await amplifyAuthenticationService.getUserID())));
  }

  Stream<TransactionsDailyState> _mapTransactionDailyUserChangedToState(String id) async* {
    yield TransactionsDailyLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    Stream<AmplifyApiEvent> stream = apiProvider.getTransactionsStream();
    _onTransactionEventSubscription = stream.listen(_onTransactionEvent);

    _observedDate = DateTime.now();
    add(TransactionsDailyFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsDailyState> _mapTransactionsDailyLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);

    print("TransactionsDailyBloc._mapTransactionsDailyLocaleChangedToState: $_sliderCurrentTimeIntervalString");

    if (state is TransactionsDailyLoaded) {
      add(TransactionsDailyDisplayRequested(
          transactions: dailyData, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    } else if (state is TransactionsDailyLoading) {
      yield TransactionsDailyLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    }
  }

  Stream<TransactionsDailyState> _mapTransactionsDailyFetchRequestedToState({required DateTime dateForFetch}) async* {
    dailyTransactionsSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield TransactionsDailyLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    dailyTransactionsSubscription = ( transactionsRepository
        .getTransactionsByTimePeriod(
            start: DateHelper().getFirstDayOfMonth(_observedDate!), end: DateHelper().getLastDayOfMonth(_observedDate!)))
        .asStream()
        .listen((event) {
      dailyData = event;
      add(TransactionsDailyDisplayRequested(
          transactions: dailyData, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    });
  }

  Stream<TransactionsDailyState> _mapTransactionDailyDisplayRequestedToState(List<AppTransaction> data) async* {
    yield TransactionsDailyLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    Map<int, List<AppTransaction>> map = sortTransactionsByDays(dailyData);
    yield TransactionsDailyLoaded(
        dailySortedTransactions: map, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
  }

  Stream<TransactionsDailyState> _mapTransactionDailyDeleteToState(String transactionId) async* {
    transactionsRepository.delete(transactionID: transactionId);
  }

  Stream<TransactionsDailyState> _mapTransactionsDailyGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(TransactionsDailyFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsDailyState> _mapTransactionsDailyGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(TransactionsDailyFetchRequested(dateForFetch: _observedDate!));
  }

  Map<int, List<AppTransaction>> sortTransactionsByDays(List<AppTransaction> list) {
    SplayTreeMap<int, List<AppTransaction>> map = SplayTreeMap();

    list.forEach((element) {
      if (!map.containsKey(element.date.getDateTimeInUtc().day)) {
        map[element.date.getDateTimeInUtc().day] = [element];
      } else {
        map[element.date.getDateTimeInUtc().day]!.add(element);
      }
    });

    return map;
  }

  _onTransactionAdded(GraphQLResponse<AppTransaction> event) async {
    print('TransactionsBloc: snapshot ${event.data}');
    if (event.data == null) {
      return;
    }

    AppTransaction transaction = event.data!;

    // TODO: split this into readable appearance..
    if ((transaction.date.getDateTimeInUtc().isAfter(DateHelper().getFirstDayOfMonth(_observedDate!)) ||
        transaction.date.getDateTimeInUtc() == DateHelper().getFirstDayOfMonth(_observedDate!)) &&
        transaction.date.getDateTimeInUtc().isBefore(DateHelper().getLastDayOfMonth(_observedDate!)) &&
        dailyData.indexWhere((element) => element.id == transaction.id) == -1) {
      dailyData.add(transaction);
      add(TransactionsDailyDisplayRequested(
          sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: dailyData));
    }
  }

  _onTransactionChanged(GraphQLResponse<AppTransaction> event) async {
    if (event.data == null) {
      return;
    }
    AppTransaction changedTransaction = event.data!;

    int oldTransactionIndex = dailyData.indexWhere((transaction) => transaction.id == changedTransaction.id);

    if (oldTransactionIndex != -1) {
      dailyData[oldTransactionIndex] = changedTransaction;
    }
    add(TransactionsDailyDisplayRequested(
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: dailyData));
  }

  _onTransactionDeleted(GraphQLResponse<AppTransaction> event) async {
    if (event.data == null) {
      return;
    }

    int index = dailyData.indexWhere((transaction) => transaction.id == event.data!.id);
    if (index != -1) {
      dailyData.removeAt(index);
    }

    add(TransactionsDailyDisplayRequested(
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: dailyData));
  }

  _onTransactionEvent(AmplifyApiEvent event) async {
    switch(event.type) {
      case AmplifyResponseType.add:
        _onTransactionAdded(event.response);
        break;
      case AmplifyResponseType.change:
        _onTransactionChanged(event.response);
        break;
      case AmplifyResponseType.delete:
        _onTransactionDeleted(event.response);
        break;
    }
  }
}
