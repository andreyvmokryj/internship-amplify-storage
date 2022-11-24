import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radency_internship_project_2/blocs/settings/settings_bloc.dart';
import 'package:radency_internship_project_2/blocs/transactions/add_transaction/temp_values.dart';
import 'package:radency_internship_project_2/generated/l10n.dart';
import 'package:radency_internship_project_2/local_models/chart_models/chart_category_details.dart';
import 'package:radency_internship_project_2/local_models/chart_models/chart_section.dart';
import 'package:radency_internship_project_2/models/AppTransaction.dart';
import 'package:radency_internship_project_2/models/ModelProvider.dart';
import 'package:radency_internship_project_2/repositories/transactions_repository.dart';
import 'package:radency_internship_project_2/utils/colours.dart';
import 'package:radency_internship_project_2/utils/date_helper.dart';

part 'expenses_chart_event.dart';

part 'expenses_chart_state.dart';

const double minimum_section_value = 10.0;

class ExpensesChartBloc extends Bloc<ExpensesChartEvent, ExpensesChartState> {
  ExpensesChartBloc({
    required this.settingsBloc,
    required this.transactionsRepository,
  }) : super(ExpensesChartInitial());

  final TransactionsRepository transactionsRepository;

  SettingsBloc settingsBloc;
  StreamSubscription? settingsSubscription;
  String locale = '';

  DateTime? _observedDate;
  String _sliderCurrentTimeIntervalString = '';

  List<AppTransaction> transactions = [];

  StreamSubscription? expensesChartTransactionsSubscription;
  StreamSubscription<AuthHubEvent>? _onUserChangedSubscription;

  @override
  Future<void> close() {
    settingsSubscription?.cancel();
    expensesChartTransactionsSubscription?.cancel();
    _onUserChangedSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ExpensesChartState> mapEventToState(
    ExpensesChartEvent event,
  ) async* {
    if (event is ExpensesChartInitialize) {
      yield* _mapExpensesChartInitializeToState();
    } else if (event is ExpensesChartGetPreviousMonthPressed) {
      yield* _mapExpensesChartGetPreviousMonthPressedToState();
    } else if (event is ExpensesChartGetNextMonthPressed) {
      yield* _mapExpensesChartGetNextMonthPressedToState();
    } else if (event is ExpensesChartFetchRequested) {
      yield* _mapExpensesChartFetchRequestedToState(dateForFetch: event.dateForFetch);
    } else if (event is ExpensesChartDisplayRequested) {
      yield* _mapTransactionDailyDisplayRequestedToState(event.transactions);
    } else if (event is ExpensesChartLocaleChanged) {
      yield* _mapExpensesChartLocaleChangedToState();
    } else if (event is ExpensesChartRefreshPressed) {
      add(ExpensesChartFetchRequested(dateForFetch: _observedDate!));
    }
  }

  Stream<ExpensesChartState> _mapExpensesChartInitializeToState() async* {
    _observedDate = DateTime.now();

    if (settingsBloc.state is LoadedSettingsState) {
      locale = settingsBloc.state.language;
    }
    settingsBloc.stream.listen((newSettingsState) {
      if (newSettingsState is LoadedSettingsState && newSettingsState.language != locale) {
        locale = newSettingsState.language;
        add(ExpensesChartLocaleChanged());
      }
    });

    _onUserChangedSubscription = Amplify.Hub.listen(HubChannel.Auth, (hubEvent) {
      if (hubEvent.payload == null) {
        transactions.clear();
        add(ExpensesChartDisplayRequested(
            sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString, transactions: transactions));
      } else {
        _observedDate = DateTime.now();
        add(ExpensesChartFetchRequested(dateForFetch: _observedDate!));
      }
    });

    add(ExpensesChartFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<ExpensesChartState> _mapExpensesChartLocaleChangedToState() async* {
    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!, locale: locale);

    if (state is ExpensesChartLoaded) {
      add(ExpensesChartDisplayRequested(
          transactions: transactions, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    } else if (state is ExpensesChartLoading) {
      yield ExpensesChartLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    }
  }

  Stream<ExpensesChartState> _mapExpensesChartFetchRequestedToState({required DateTime dateForFetch}) async* {
    expensesChartTransactionsSubscription?.cancel();

    _sliderCurrentTimeIntervalString = DateHelper().monthNameAndYearFromDateTimeString(_observedDate!);
    yield ExpensesChartLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
    expensesChartTransactionsSubscription = (await transactionsRepository
        .getTransactionsByTimePeriod(
          start: DateHelper().getFirstDayOfMonth(dateForFetch),
          end: DateHelper().getLastDayOfMonth(dateForFetch),
        ))
        .listen((event) {
      transactions = event.items;
      add(ExpensesChartDisplayRequested(
          transactions: transactions, sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString));
    });
  }

  Stream<ExpensesChartState> _mapTransactionDailyDisplayRequestedToState(List<AppTransaction> data) async* {
    yield ExpensesChartLoading(sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);

    List<ChartCategoryDetails> allCategories = getChartCategoriesFromTransactions(data);
    List<ChartSection> chartCategories = convertChartCategoriesToChartData(allCategories);

    yield ExpensesChartLoaded(
        allCategories: allCategories,
        chartCategories: chartCategories,
        sliderCurrentTimeIntervalString: _sliderCurrentTimeIntervalString);
  }

  Stream<ExpensesChartState> _mapExpensesChartGetPreviousMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month - 1);
    add(ExpensesChartFetchRequested(dateForFetch: _observedDate!));
  }

  Stream<ExpensesChartState> _mapExpensesChartGetNextMonthPressedToState() async* {
    _observedDate = DateTime(_observedDate!.year, _observedDate!.month + 1);
    add(ExpensesChartFetchRequested(dateForFetch: _observedDate!));
  }

  List<ChartCategoryDetails> getChartCategoriesFromTransactions(List<AppTransaction> transactions) {
    List<ChartCategoryDetails> categories = [];
    bool isOtherGroupAdded = false;
    String otherGroupName = S.current.categoriesDefaultOther;

    if (transactions.isEmpty) {
      return categories;
    }

    TempTransactionsValues().expenseCategories.forEach((category) {
      categories.add(ChartCategoryDetails(categoryName: category, value: 0.0));
    });

    double totalAmount = 0.0;

    // Splitting into categories
    transactions.forEach((transaction) {
      if (transaction.transactionType == TransactionType.Expense) {
        int categoryIndex =
            categories.indexWhere((categoryExpenses) => categoryExpenses.categoryName == transaction.category);

        // TODO: check for category id instead of name when (if) implemented

        // index -1 means that transaction's category was deleted/changed
        if (categoryIndex == -1) {
          if (!isOtherGroupAdded) {
            categories.add(ChartCategoryDetails(categoryName: otherGroupName, value: 0.0));
            isOtherGroupAdded = true;
          }
          categories.where((element) => element.categoryName == otherGroupName).first.value += transaction.amount;
        } else {
          categories[categoryIndex].value += transaction.amount;
        }
      }
    });

    categories.removeWhere((element) => element.value == 0.0);

    // Calculating totals
    categories.forEach((element) {
      totalAmount += element.value;
    });

    // Calculating percentage
    categories.forEach((element) {
      double part = element.value / totalAmount * 100;
      element.percents = double.parse(part.toStringAsFixed(2));
    });

    // Sorting by category values
    categories.sort((a, b) {
      return b.value.compareTo(a.value);
    });

    // Moving 'Other' to end
    if (isOtherGroupAdded) {
      ChartCategoryDetails tempOther = categories.where((element) => element.categoryName == otherGroupName).first;
      categories.removeWhere((element) => element.categoryName == otherGroupName);
      categories.add(tempOther);
    }

    // Applying colors.
    for (int index = 0; index < categories.length; index++) {
      bool isCategoryShouldHaveSection = isCategoryFitInChart(index: index, percentage: categories[index].percents);

      // TODO: Hardcoded colors should be removed in favour of function that returns list of colors based on main
      // theme color
      if (isCategoryShouldHaveSection && categories[index].categoryName != otherGroupName) {
        categories[index].color = Colours().chartColors[index];
      } else {
        categories[index].color = Colours().chartColors[Colours().chartColors.length - 1];
      }
    }

    return categories;
  }

  List<ChartSection> convertChartCategoriesToChartData(List<ChartCategoryDetails> categories) {
    List<ChartSection> chartData = [];

    String otherGroupName = S.current.categoriesDefaultOther;
    double otherGroupValue = 0.0;

    if (categories.isEmpty) {
      return chartData;
    }

    for (int index = 0; index < categories.length; index++) {
      bool isCategoryShouldHaveSection = isCategoryFitInChart(index: index, percentage: categories[index].percents);

      if (isCategoryShouldHaveSection && categories[index].categoryName != otherGroupName) {
        chartData.add(ChartSection(
          categoryName: categories[index].categoryName,
          percents: categories[index].percents,
          color: Colours().chartColors[index],
        ));
      } else {
        otherGroupValue += categories[index].percents;
      }
    }

    if (otherGroupValue > 0.0) {
      chartData.add(ChartSection(
        categoryName: otherGroupName,
        color: Colours().chartColors[Colours().chartColors.length - 1],
        percents: otherGroupValue,
      ));
    }

    // Sorting by category values
    categories.sort((a, b) {
      return b.value.compareTo(a.value);
    });

    return chartData;
  }

  bool isCategoryFitInChart({required int index, required double percentage}) {
    if (index < Colours().chartColors.length && percentage > minimum_section_value) {
      return true;
    } else
      return false;
  }
}
