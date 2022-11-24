import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/utils/mocked_expenses.dart';

part 'search_transactions_event.dart';
part 'search_transactions_state.dart';

class SearchTransactionsBloc extends Bloc<SearchTransactionsEvent, SearchTransactionsState>{
  SearchTransactionsBloc() : super(SearchTransactionsInitial());

  StreamSubscription? searchTransactionsSubscription;

  @override
  Future<void> close() {
    searchTransactionsSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<SearchTransactionsState> mapEventToState(SearchTransactionsEvent event) async* {
    if(event is SearchTransactionsInitialize) yield* _mapSearchTransactionsInitializeToState();
    if(event is SearchTransactionsByFilters) yield* _mapSearchTransactionsByFiltersToState(event);
    if(event is SearchTransactionsDisplayRequested) yield* _mapSearchTransactionsDisplayRequestedToState(event);
  }

  Stream<SearchTransactionsState> _mapSearchTransactionsInitializeToState() async* {
    searchTransactionsSubscription?.cancel();
    yield SearchTransactionsLoading();
    searchTransactionsSubscription = Future.delayed(Duration(seconds: 2)).asStream().listen((event) {
      // TODO: Implement fetch endpoint
      List<AppTransaction> transactions = MockedExpensesItems().generateSearchData();
      add(SearchTransactionsDisplayRequested(transactions: transactions));
    });
  }

  Stream<SearchTransactionsState> _mapSearchTransactionsByFiltersToState(SearchTransactionsByFilters event) async* {
    searchTransactionsSubscription?.cancel();
    yield SearchTransactionsLoading();
    searchTransactionsSubscription = Future.delayed(Duration(seconds: 2)).asStream().listen((_event) {
      // TODO: Implement fetch endpoint
      List<AppTransaction> transactions = MockedExpensesItems().searchDataByFilters(
        searchAccounts: event.accounts,
        searchCategories: event.categories,
        minAmount: event.minAmount,
        maxAmount: event.maxAmount,
      );
      add(SearchTransactionsDisplayRequested(transactions: transactions));
    });
  }

  Stream<SearchTransactionsState> _mapSearchTransactionsDisplayRequestedToState(SearchTransactionsDisplayRequested event) async* {
    yield SearchTransactionsLoaded(transactions: event.transactions);
  }
}