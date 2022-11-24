import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/local_models/transactions/week_details.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'transactions_weekly_event.dart';

part 'transactions_weekly_state.dart';

class TransactionsWeeklyBloc extends Bloc<TransactionsWeeklyEvent, TransactionsWeeklyState> {
  TransactionsWeeklyBloc({
    required this.transactionsRepository,
  })
      : super(TransactionsWeeklyInitial());

  final TransactionsRepository transactionsRepository;

  /// In accordance with ISO 8601
  /// a week starts with Monday, which has the value 1.
  final int startOfWeek = 1;
  final int endOfWeek = 7;

  List<AppTransaction> observedMonthTransactions = [];

  DateTime _observedDate = DateTime.now();
  String _sliderCurrentTimeIntervalString = '';

  StreamSubscription? _weeklyTransactionsSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;

  @override
  Future<void> close() {
    _weeklyTransactionsSubscription?.cancel();
    _onUserChangedSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TransactionsWeeklyState> mapEventToState(
    TransactionsWeeklyEvent event,
  ) async* {
    if (event is TransactionsWeeklyInitialize) {
      yield* _mapTransactionsWeeklyInitializeToState();
    } else if (event is TransactionsWeeklyGetPreviousMonthPressed) {
      yield* _mapTransactionsWeeklyGetPreviousMonthPressedToState();
    } else if (event is TransactionsWeeklyGetNextMonthPressed) {
      yield* _mapTransactionsWeeklyGetNextMonthPressedToState();
    } else if (event is TransactionsWeeklyFetchRequested) {
      yield* _mapTransactionsWeeklyFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is TransactionWeeklyDisplayRequested) {
      yield* _mapTransactionWeeklyDisplayRequestedToState(event.transactions);
    } else if (event is TransactionWeeklyRefreshPressed) {
      add(TransactionsWeeklyFetchRequested(dateForFetch: _observedDate));
    }
  }

  Stream<TransactionsWeeklyState> _mapTransactionsWeeklyFetchRequestedToState({
    required DateTime dateForFetch,
  }) async* {
    _weeklyTransactionsSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().getWeeksRangeString(
        firstDay: _getFirstDayOfCurrentRange(dateTime: _observedDate),
        lastDay: _getLastDayOfCurrentRange(dateTime: _observedDate));

    yield TransactionsWeeklyLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    _weeklyTransactionsSubscription = (await transactionsRepository
        .getTransactionsByTimePeriod(
          start: _getFirstDayOfCurrentRange(dateTime: _observedDate),
          end: _getLastDayOfCurrentRange(dateTime: _observedDate),
        ))
        .listen((event) {
      observedMonthTransactions = event.items;

      add(TransactionWeeklyDisplayRequested(
          transactions: observedMonthTransactions, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    });
  }

  Stream<TransactionsWeeklyState> _mapTransactionWeeklyDisplayRequestedToState(List<AppTransaction> data) async* {
    List<WeekDetails> observedMonthSummaryByWeeks = _getSummaryFromTransactionsList(data);

    yield TransactionsWeeklyLoaded(
        summaryList: observedMonthSummaryByWeeks, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
  }

  Stream<TransactionsWeeklyState> _mapTransactionsWeeklyInitializeToState() async* {
    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      if (hubEvent.payload == null) {
        observedMonthTransactions.clear();
        add(TransactionWeeklyDisplayRequested(
            sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
            transactions: observedMonthTransactions));
      } else {
        _observedDate = DateTime.now();
        add(TransactionsWeeklyFetchRequested(dateForFetch: _observedDate));
      }
    });

    _observedDate = DateTime.now();
    add(TransactionsWeeklyFetchRequested(dateForFetch: _observedDate));
  }

  Stream<TransactionsWeeklyState> _mapTransactionsWeeklyGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate.year, _observedDate.month - 1);
    add(TransactionsWeeklyFetchRequested(dateForFetch: _observedDate));
  }

  Stream<TransactionsWeeklyState> _mapTransactionsWeeklyGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate.year, _observedDate.month + 1);
    add(TransactionsWeeklyFetchRequested(dateForFetch: _observedDate));
  }

  List<WeekDetails> _getSummaryFromTransactionsList(List<AppTransaction> data) {
    List<WeekDetails> list = [];

    if (data.isEmpty) {
      return list;
    }

    DateTime firstDay = _getFirstDayOfCurrentRange(dateTime: _observedDate);
    DateTime lastDay = _getLastDayOfCurrentRange(dateTime: _observedDate);
    int difference = lastDay.difference(firstDay).inDays;
    int numberOfWeeks = difference ~/ 7;

    for (int weekNumber = 0; weekNumber <= numberOfWeeks; weekNumber++) {
      DateTime weekFirstDay = DateTime(firstDay.year, firstDay.month, firstDay.day).add(Duration(days: 7 * weekNumber));
      DateTime weekLastDay = DateTime(weekFirstDay.year, weekFirstDay.month, weekFirstDay.day).add(Duration(days: 6));

      list.add(WeekDetails(
        weekNumberInSet: weekNumber,
        income: 0.0,
        expenses: 0.0,
        firstDay: weekFirstDay,
        lastDay: weekLastDay,
        rangeString: DateHelper().getWeeksRangeString(firstDay: weekFirstDay, lastDay: weekLastDay, oneWeekMode: true),
      ));
    }

    data.forEach((transaction) {
      int transactionWeekInCurrentSet = transaction.date.getDateTimeInUtc().difference(firstDay).inDays ~/ 7;

      if (transaction.transactionType == TransactionType.Expense) {
        list.where((weekSummary) => weekSummary.weekNumberInSet == transactionWeekInCurrentSet).first.expenses +=
            transaction.amount;
      } else if (transaction.transactionType == TransactionType.Income) {
        list.where((weekSummary) => weekSummary.weekNumberInSet == transactionWeekInCurrentSet).first.income +=
            transaction.amount;
      }
    });

    list.removeWhere((element) => (element.income == 0.0 && element.expenses == 0.0));

    return list;
  }

  DateTime _getFirstDayOfCurrentRange({required DateTime dateTime}) {
    DateTime startOfFirstWeekForCurrentMonth = DateTime(dateTime.year, dateTime.month, 1);
    while (startOfFirstWeekForCurrentMonth.weekday != startOfWeek) {
      startOfFirstWeekForCurrentMonth = DateTime(startOfFirstWeekForCurrentMonth.year,
          startOfFirstWeekForCurrentMonth.month, startOfFirstWeekForCurrentMonth.day - 1);
    }

    return startOfFirstWeekForCurrentMonth;
  }

  DateTime _getLastDayOfCurrentRange({required DateTime dateTime}) {
    DateTime endOfLastWeekForCurrentMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
    while (endOfLastWeekForCurrentMonth.weekday != endOfWeek) {
      endOfLastWeekForCurrentMonth = DateTime(
          endOfLastWeekForCurrentMonth.year, endOfLastWeekForCurrentMonth.month, endOfLastWeekForCurrentMonth.day + 1);
    }
    return endOfLastWeekForCurrentMonth;
  }
}
