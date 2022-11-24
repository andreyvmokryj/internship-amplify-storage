import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/local_models/transactions/summary_details.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/TransactionType.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'transactions_summary_event.dart';

part 'transactions_summary_state.dart';

class TransactionsSummaryBloc extends Bloc<TransactionsSummaryEvent, TransactionsSummaryState> {
  TransactionsSummaryBloc({
    required this.settingsBloc,
    required this.transactionsRepository,
  }) : super(TransactionsSummaryInitial());

  final TransactionsRepository transactionsRepository;
  final SettingsBloc settingsBloc;

  StreamSubscription? settingsSubscription;
  String locale = '';

  StreamSubscription? summaryTransactionsSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';

  List<AppTransaction> transactions = [];

  @override
  Future<void> close() {
    summaryTransactionsSubscription?.cancel();
    settingsSubscription?.cancel();
    _onUserChangedSubscription?.cancel();

    return super.close();
  }

  @override
  Stream<TransactionsSummaryState> mapEventToState(
    TransactionsSummaryEvent event,
  ) async* {
    if (event is TransactionsSummaryInitialize) {
      yield* _mapTransactionsSummaryInitializeToState();
    } else if (event is TransactionsSummaryGetPreviousMonthPressed) {
      yield* _mapTransactionsSummaryGetPreviousMonthPressedToState();
    } else if (event is TransactionsSummaryGetNextMonthPressed) {
      yield* _mapTransactionsSummaryGetNextMonthPressedToState();
    } else if (event is TransactionsSummaryFetchRequested) {
      yield* _mapTransactionsSummaryFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is TransactionSummaryDisplayRequested) {
      yield* _mapTransactionSummaryDisplayRequestedToState(event.sliderCurrentTimeIntervalString, event.transactions);
    } else if (event is TransactionsSummaryLocaleChanged) {
      yield* _mapTransactionsSummaryLocaleChangedToState();
    } else if (event is TransactionsSummaryRefreshPressed) {
      add(TransactionsSummaryFetchRequested(dateForFetch: _observedDate!));
    }
  }

  Stream<TransactionsSummaryState> _mapTransactionsSummaryInitializeToState() async* {
    _observedDate = DateTime.now();

    if (settingsBloc.state is LoadedSettingsState) locale = settingsBloc.state.language;
    settingsBloc.stream.listen((newSettingsState) {
      if (newSettingsState is LoadedSettingsState) {
        if (newSettingsState.language != locale) {
          locale = newSettingsState.language;

          add(TransactionsSummaryLocaleChanged());
        }
      }
    });

    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      if (hubEvent.payload == null) {
        transactions.clear();
        add(TransactionSummaryDisplayRequested(
            sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: transactions));
      } else {
        _observedDate = DateTime.now();
        add(TransactionsSummaryFetchRequested(dateForFetch: _observedDate!));
      }
    });

    add(TransactionsSummaryFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsSummaryState> _mapTransactionsSummaryLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);
    if (state is TransactionsSummaryLoaded) {
      add(TransactionSummaryDisplayRequested(
          transactions: transactions, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    } else if (state is TransactionsSummaryLoading) {
      yield TransactionsSummaryLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    }
  }

  Stream<TransactionsSummaryState> _mapTransactionsSummaryFetchRequestedToState(
      {required DateTime dateForFetch}) async* {
    summaryTransactionsSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield TransactionsSummaryLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    summaryTransactionsSubscription = (await transactionsRepository
        .getTransactionsByTimePeriod(
            start: DateHelper().getFirstDayOfMonth(dateForFetch),
            end: DateHelper().getLastDayOfMonth(dateForFetch)))
        .listen((event) {
      transactions = event.items;
      add(TransactionSummaryDisplayRequested(
          sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: transactions));
    });
  }

  Stream<TransactionsSummaryState> _mapTransactionSummaryDisplayRequestedToState(
      String data, List<AppTransaction> transactions) async* {
    SummaryDetails summary = _convertTransactionsToSummary(transactions);

    yield TransactionsSummaryLoaded(
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, summaryDetails: summary);
  }

  Stream<TransactionsSummaryState> _mapTransactionsSummaryGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(TransactionsSummaryFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<TransactionsSummaryState> _mapTransactionsSummaryGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(TransactionsSummaryFetchRequested(dateForFetch: _observedDate!));
  }

  SummaryDetails _convertTransactionsToSummary(List<AppTransaction> transactions) {
    SummaryDetails summaryDetails = SummaryDetails(income: 0.0, expenses: 0.0, total: 0.0, accountsExpensesDetails: {});

    if (transactions.isEmpty) {
      return summaryDetails;
    }

    transactions.forEach((transaction) {
      if (transaction.transactionType == TransactionType.Expense) {
        bool categoryExists = summaryDetails.accountsExpensesDetails.containsKey(transaction.category);

        if (!categoryExists) {
          summaryDetails.accountsExpensesDetails[transaction.category!] = 0.0;
        }

        summaryDetails.accountsExpensesDetails[transaction.category!] =
            (summaryDetails.accountsExpensesDetails[transaction.category] ?? 0) + transaction.amount;

        summaryDetails.expenses += transaction.amount;
      }

      if (transaction.transactionType == TransactionType.Income) {
        summaryDetails.income += transaction.amount;
      }
    });

    summaryDetails.total = summaryDetails.income - summaryDetails.expenses;
    return summaryDetails;
  }
}
