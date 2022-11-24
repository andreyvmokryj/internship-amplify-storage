import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/budget/category_budget.dart';
import 'package:radency_internship_project_2/local_models/budget/monthly_category_expense.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/repositories/budgets_repository.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'budget_overview_event.dart';

part 'budget_overview_state.dart';

class BudgetOverviewBloc extends Bloc<BudgetOverviewEvent, BudgetOverviewState> {
  BudgetOverviewBloc({required this.settingsBloc,
    required this.budgetsRepository,
    required this.transactionsRepository,
  }) : super(BudgetOverviewInitial());

  final TransactionsRepository transactionsRepository;

  SettingsBloc settingsBloc;
  StreamSubscription? settingsSubscription;
  String locale = '';

  BudgetsRepository budgetsRepository;

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';

  List<AppTransaction> transactions = [];
  List<MonthlyCategoryExpense> monthlyCategoryExpenses = [];
  List<CategoryBudget> budgets = [];

  MonthlyCategoryExpense? summary;

  StreamSubscription? budgetOverviewSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;

  @override
  Future<void> close() {
    budgetOverviewSubscription?.cancel();
    _onUserChangedSubscription?.cancel();
    settingsSubscription?.cancel();

    return super.close();
  }

  @override
  Stream<BudgetOverviewState> mapEventToState(
    BudgetOverviewEvent event,
  ) async* {
    if (event is BudgetOverviewInitialize) {
      yield* _mapBudgetOverviewInitializeToState();
    } else if (event is BudgetOverviewGetPreviousMonthPressed) {
      yield* _mapBudgetOverviewGetPreviousMonthPressedToState();
    } else if (event is BudgetOverviewGetNextMonthPressed) {
      yield* _mapBudgetOverviewGetNextMonthPressedToState();
    } else if (event is BudgetOverviewFetchRequested) {
      yield* _mapBudgetOverviewFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is BudgetOverviewDisplayRequested) {
      yield* _mapTransactionDailyDisplayRequestedToState();
    } else if (event is BudgetOverviewCategoryBudgetSaved) {
      yield* _mapBudgetOverviewCategoryBudgetSavedToState(event.categoryBudget);
    } else if (event is BudgetOverviewLocaleChanged) {
      yield* _mapBudgetOverviewLocaleChangedToState();
    } else if (event is BudgetOverviewUserChanged) {
      yield* _mapBudgetOverviewUserChangedToState(event.userId);
    }
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewInitializeToState() async* {
    _observedDate = DateTime.now();
    await _fetchSavedBudget();

    if (settingsBloc.state is LoadedSettingsState) {
      locale = settingsBloc.state.language;
    }
    settingsBloc.stream.listen((newSettingsState) {
      if (newSettingsState is LoadedSettingsState && newSettingsState.language != locale) {
        locale = newSettingsState.language;
        add(BudgetOverviewLocaleChanged());
      }
    });

    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      if (hubEvent.payload == null) {
        transactions.clear();
        monthlyCategoryExpenses.clear();
        budgets.clear();

        monthlyCategoryExpenses = _getMonthlyCategoriesExpenses(transactions);

        add(BudgetOverviewDisplayRequested());
      } else {
        _observedDate = DateTime.now();
        add(BudgetOverviewUserChanged(userId: hubEvent.payload!.userId));
      }
    });

    add(BudgetOverviewFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);

    if (state is BudgetOverviewLoaded) {
      yield BudgetOverviewLoaded(
          sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
          monthlyCategoryExpenses: monthlyCategoryExpenses,
          summary: summary!);
    } else if (state is BudgetOverviewLoading) {
      yield BudgetOverviewLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    }
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewUserChangedToState(String id) async* {
    yield BudgetOverviewLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    _observedDate = DateTime.now();
    add(BudgetOverviewFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewFetchRequestedToState({required DateTime dateForFetch}) async* {
    budgetOverviewSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield BudgetOverviewLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    budgetOverviewSubscription = (await transactionsRepository
        .getTransactionsByTimePeriod(
            start: DateHelper().getFirstDayOfMonth(_observedDate!), end: DateHelper().getLastDayOfMonth(_observedDate!)))
        .listen((event) {
      monthlyCategoryExpenses.clear();
      transactions = event.items;
      add(BudgetOverviewDisplayRequested());
    });
  }

  Stream<BudgetOverviewState> _mapTransactionDailyDisplayRequestedToState() async* {
    monthlyCategoryExpenses = _getMonthlyCategoriesExpenses(transactions);

    _sortCategories();
    _calculateBudgetSummary();

    yield BudgetOverviewLoaded(
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString,
        monthlyCategoryExpenses: monthlyCategoryExpenses,
        summary: summary!);
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(BudgetOverviewFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(BudgetOverviewFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<BudgetOverviewState> _mapBudgetOverviewCategoryBudgetSavedToState(CategoryBudget categoryBudget) async* {
    await budgetsRepository.update(categoryBudget: categoryBudget);
    await _fetchSavedBudget();

    add(BudgetOverviewDisplayRequested());
  }

  Future<void> _fetchSavedBudget() async {
    // TODO: add user identifier to budget records/fetch from cloud
    budgets = await budgetsRepository.findAll();
  }

  void _sortCategories() {
    if (budgets.isNotEmpty) {
      budgets.forEach((budgetEntry) {
        print("BudgetOverviewBloc._sortCategories: ${budgetEntry.category} ${budgetEntry.budgetValue}");
        if (monthlyCategoryExpenses
                .indexWhere((monthlyCategoryExpense) => monthlyCategoryExpense.category == budgetEntry.category) !=
            -1) {
          monthlyCategoryExpenses
              .firstWhere((monthlyCategoryExpense) => monthlyCategoryExpense.category == budgetEntry.category)
              .budgetTotal = budgetEntry.budgetValue;
        }
      });
    }

    // Calculating usage
    monthlyCategoryExpenses.forEach((monthlyCategoryExpense) {
      monthlyCategoryExpense.budgetLeft = monthlyCategoryExpense.budgetTotal - monthlyCategoryExpense.expenseAmount;
      monthlyCategoryExpense.budgetUsage = monthlyCategoryExpense.expenseAmount / monthlyCategoryExpense.budgetTotal;
    });

    monthlyCategoryExpenses.sort((a, b) => b.expenseAmount.compareTo(a.expenseAmount));
    monthlyCategoryExpenses.sort((a, b) => b.budgetTotal.compareTo(a.budgetTotal));
  }

  void _calculateBudgetSummary() {
    double summaryBudgetSpent = 0;
    double summaryBudgetTotal = 0;

    // Calculating usage and leftover
    monthlyCategoryExpenses.forEach((monthlyCategoryExpense) {
      if (monthlyCategoryExpense.budgetTotal > 0) {
        summaryBudgetTotal += monthlyCategoryExpense.budgetTotal;
        summaryBudgetSpent += monthlyCategoryExpense.expenseAmount;
      }
    });

    double summaryBudgetLeft = summaryBudgetTotal - summaryBudgetSpent;
    double summaryBudgetUsage = summaryBudgetSpent / summaryBudgetTotal;

    summary = MonthlyCategoryExpense(
        category: S.current.statsBudgetMonthlyTotalTitle,
        expenseAmount: summaryBudgetSpent,
        budgetTotal: summaryBudgetTotal,
        budgetLeft: summaryBudgetLeft,
        budgetUsage: summaryBudgetUsage);
  }

  List<MonthlyCategoryExpense> _getMonthlyCategoriesExpenses(List<AppTransaction> transactions) {
    List<MonthlyCategoryExpense> list = [];
    bool isOtherGroupAdded = false;

    TempTransactionsValues().expenseCategories.forEach((element) {
      list.add(MonthlyCategoryExpense(category: element, expenseAmount: 0.0));
    });

    transactions.forEach((transaction) {
      if (transaction.transactionType == TransactionType.Expense) {
        int categoryIndex = list.indexWhere((categoryExpenses) => categoryExpenses.category == transaction.category);

        // TODO: check for category id instead of name when (if) implemented

        // index -1 means that transaction's category was deleted/changed
        if (categoryIndex == -1) {
          if (!isOtherGroupAdded) {
            list.add(MonthlyCategoryExpense(category: S.current.categoriesDefaultOther, expenseAmount: 0.0));
            isOtherGroupAdded = true;
          }
          list.where((element) => element.category == S.current.categoriesDefaultOther).first.expenseAmount +=
              transaction.amount;
        } else {
          list[categoryIndex].expenseAmount += transaction.amount;
        }
      }
    });

    return list;
  }
}
