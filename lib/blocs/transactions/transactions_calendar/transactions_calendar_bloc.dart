import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/local_models/calendar_day.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'transactions_calendar_event.dart';

part 'transactions_calendar_state.dart';

class TransactionsCalendarBloc extends Bloc<TransactionsCalendarEvent, TransactionsCalendarState> {
  TransactionsCalendarBloc({
    required this.settingsBloc,
    required this.transactionsRepository,
  }) : super(TransactionsCalendarInitial());

  final TransactionsRepository transactionsRepository;

  SettingsBloc settingsBloc;
  StreamSubscription? settingsSubscription;
  String locale = '';

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';

  List<AppTransaction> transactionsList = [];
  List<CalendarDay> calendarData = [];
  double expensesSummary = 0;
  double incomeSummary = 0;

  /// In accordance with ISO 8601
  /// a week starts with Monday, which has the value 1.
  final int startOfWeek = 1;
  final int endOfWeek = 7;

  StreamSubscription? calendarTransactionsSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;

  @override
  Stream<TransactionsCalendarState> mapEventToState(
    TransactionsCalendarEvent event,
  ) async* {
    if (event is TransactionsCalendarInitialize) {
      yield* _mapTransactionsCalendarInitializeToState();
    } else if (event is TransactionsCalendarGetPreviousMonthPressed) {
      yield* _mapTransactionsCalendarGetPreviousMonthPressedToState();
    } else if (event is TransactionsCalendarGetNextMonthPressed) {
      yield* _mapTransactionsCalendarGetNextMonthPressedToState();
    } else if (event is TransactionsCalendarFetchRequested) {
      yield* _mapTransactionsCalendarFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is TransactionsCalendarDisplayRequested) {
      yield* _mapTransactionCalendarDisplayRequestedToState(
        data: event.daysData,
        expenses: event.expensesSummary,
        income: event.incomeSummary,
      );
    } else if (event is TransactionsCalendarLocaleChanged) {
      yield* _mapTransactionsCalendarLocaleChangedToState();
    } else if (event is TransactionsCalendarUserChanged) {
      yield* _mapTransactionsCalendarUserChangedToState(event.id);
    }
  }

  @override
  Future<void> close() {
    calendarTransactionsSubscription?.cancel();
    settingsSubscription?.cancel();
    _onUserChangedSubscription?.cancel();
    return super.close();
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarInitializeToState() async* {
    _observedDate = DateTime.now();
    add(TransactionsCalendarFetchRequested(dateForFetch: _observedDate!));

    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      if (hubEvent.payload == null) {
        calendarData.clear();
        transactionsList.clear();
        add(TransactionsCalendarDisplayRequested(
          sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
          daysData: calendarData,
          incomeSummary: 0.0,
          expensesSummary: 0.0,
        ));
      } else {
        add(TransactionsCalendarUserChanged(id: hubEvent.payload!.userId));
      }
    });

    if (settingsBloc.state is LoadedSettingsState) {
      locale = settingsBloc.state.language;
    }
    settingsBloc.stream.listen((newSettingsState) {
      print("TransactionsCalendarBloc._mapTransactionsCalendarInitializeToState: newSettingsState");
      if (newSettingsState is LoadedSettingsState && newSettingsState.language != locale) {
        locale = newSettingsState.language;
        add(TransactionsCalendarLocaleChanged());
      }
    });
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);

    print("TransactionsCalendarBloc._mapTransactionsCalendarLocaleChangedToState: $_sliderCurrentTimeIntervalString");

    if (state is TransactionsCalendarLoaded) {
      add(TransactionsCalendarDisplayRequested(
        daysData: calendarData,
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
        expensesSummary: expensesSummary,
        incomeSummary: incomeSummary,
      ));
    } else if (state is TransactionsCalendarLoading) {
      yield TransactionsCalendarLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    }
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarFetchRequestedToState(
      {required DateTime dateForFetch}) async* {
    calendarTransactionsSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield TransactionsCalendarLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    calendarTransactionsSubscription = (await transactionsRepository
        .getTransactionsByTimePeriod(
            start: DateHelper().getFirstDayOfMonth(_observedDate!), end: DateHelper().getLastDayOfMonth(_observedDate!)))
        .listen((event) {
      transactionsList = event.items;
      calendarData = _convertTransactionsToCalendarData(transactionsList, _observedDate!);
      add(TransactionsCalendarDisplayRequested(
        daysData: calendarData,
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
        expensesSummary: expensesSummary,
        incomeSummary: incomeSummary,
      ));
    });
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarUserChangedToState(String id) async* {
    yield TransactionsCalendarLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    _observedDate = DateTime.now();
    add(TransactionsCalendarFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsCalendarState> _mapTransactionCalendarDisplayRequestedToState(
      {required List<CalendarDay> data, required double income, required double expenses}) async* {
    yield TransactionsCalendarLoaded(
        daysData: data,
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
        incomeSummary: income,
        expensesSummary: expenses);
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(TransactionsCalendarFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsCalendarState> _mapTransactionsCalendarGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(TransactionsCalendarFetchRequested(dateForFetch: _observedDate!));
  }

  List<CalendarDay> _convertTransactionsToCalendarData(List<AppTransaction> transactions, DateTime observedDateTime) {
    List<CalendarDay> days = [];
    incomeSummary = 0;
    expensesSummary = 0;

    int currentMonth = observedDateTime.month;

    DateTime observedDay = DateTime(observedDateTime.year, observedDateTime.month, 1);
    while (observedDay.weekday != startOfWeek) {
      observedDay = DateTime(observedDay.year, observedDay.month, observedDay.day - 1);
    }

    while (days.length != 42) {
      List<AppTransaction> dayTransactions = [];
      String displayedDate = observedDay.day == 1 ? '${observedDay.day}.${observedDay.month}' : '${observedDay.day}';
      double expensesAmount = 0;
      double incomeAmount = 0;
      double transferAmount = 0;

      if (observedDay.month == currentMonth) {
        transactions.forEach((element) {
          if (element.date.getDateTimeInUtc().month == observedDay.month && element.date.getDateTimeInUtc().day == observedDay.day) {
            dayTransactions.add(element);

            if (element.transactionType == TransactionType.Expense) {
              expensesAmount = expensesAmount + element.amount;
              expensesSummary = expensesSummary + element.amount;
            } else if (element.transactionType == TransactionType.Income) {
              incomeAmount = incomeAmount + element.amount;
              incomeSummary = incomeSummary + element.amount;
            } else if (element.transactionType == TransactionType.Transfer) {
              transferAmount = transferAmount + element.amount;
            }
          }
        });
      }

      days.add(CalendarDay(
          dateTime: observedDay,
          displayedDate: displayedDate,
          isActive: observedDay.month == currentMonth,
          transactions: dayTransactions,
          expensesAmount: expensesAmount,
          incomeAmount: incomeAmount,
          transferAmount: transferAmount));

      observedDay = DateTime(observedDay.year, observedDay.month, observedDay.day + 1);
    }

    return days;
  }
}
